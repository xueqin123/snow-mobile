import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:imlib/core/inbound/handler/notify_handler.dart';
import 'package:imlib/core/snow_im_connect_manager.dart';
import 'package:imlib/core/inbound/handler/conversation_handler.dart';
import 'package:imlib/core/inbound/handler/history_message_handler.dart';
import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/entity/host_entity.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/service/snow_im_host_service.dart';
import 'package:imlib/rest/snow_fetch_helper.dart';
import 'package:imlib/rest/snow_im_http_manager.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

import 'inbound/handler/auth_handler.dart';
import 'inbound/handler/heart_beat_handler.dart';
import 'inbound/handler/message_ack_handler.dart';
import 'inbound/handler/message_handler.dart';
import 'inbound/inbound_chain.dart';
import 'inbound/protobuf_varint_32_frame_decoder.dart';
import 'inbound/snow_message_decoder.dart';
import 'outbound/encoder/protobuf_varint_32_length_field_prepender.dart';
import 'outbound/encoder/snow_message_encoder.dart';

class SnowIMContext {
  static SnowIMContext _instance;
  String selfUid;
  String token;

  SnowIMContext._();

  Socket _socket;

  InboundChain _inHead;
  InboundChain _inTail;
  OutboundEncoder _outHead;
  OutboundEncoder _outTail;

  // ignore: close_sinks
  StreamController<CustomMessage> _customMessageStreamController = StreamController();

  ProtobufVarint32FrameDecoder protobufVarint32FrameDecoder = ProtobufVarint32FrameDecoder();
  SnowMessageDecoder _snowMessageDecoder = new SnowMessageDecoder();
  Map<Int64, SendBlock> _waitAckMap = LinkedHashMap();

  static SnowIMContext getInstance() {
    if (_instance == null) {
      _instance = SnowIMContext._();
    }
    _instance.addInBoundHandler(AuthHandler());
    _instance.addInBoundHandler(HeardBeatHandler());
    _instance.addInBoundHandler(ConversationHandler());
    _instance.addInBoundHandler(HistoryMessageHandler());
    _instance.addInBoundHandler(MessageAckHandler());
    _instance.addInBoundHandler(MessageHandler());
    _instance.addInBoundHandler(NotifyHandler());

    _instance.addOutBoundEncoder(SnowMessageEncoder());
    _instance.addOutBoundEncoder(ProtobufVarint32LengthFieldPrepender());
    return _instance;
  }

  StreamController<CustomMessage> getCustomMessageController() {
    return _customMessageStreamController;
  }

  StreamController<List<Conversation>> getConversationListController() {
    return SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().getConversationController();
  }

  connect(String token) async {
    HostEntity hostInfo = await SnowIMHttpManager.getInstance().getService<SnowIMHostService>().getHost(token);
    SLog.i("SnowIMContext token:{$token} connect host: {$hostInfo}");
    if (hostInfo != null) {
      await _connect(hostInfo.ip, hostInfo.port);
      _sendLogin(token, selfUid);
    }
  }

  //connect 之前先init
  init(String uid, String token) async {
    this.selfUid = uid;
    SnowIMHttpManager.getInstance().init(token);
    await SnowIMDaoManager.getInstance().init(selfUid);
    SnowIMModelManager.getInstance().init();
    SnowIMConnectManager.getInstance().init(this, token);
  }

  _connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    _socket.listen(
      (event) {
        SLog.v("socket listen event:${event.length}");
        List<Uint8List> packages = protobufVarint32FrameDecoder.decode(event);
        if (packages != null) {
          packages.forEach((element) {
            _onReceiveData(_snowMessageDecoder.decode(element));
          });
        }
      },
      onDone: () => SnowIMConnectManager.getInstance().onSocketDone(),
      onError: (e) => SnowIMConnectManager.getInstance().onSocketError(e),
    );
  }

  disConnect() async {
    await _socket.close();
    _socket = null;
  }

  _onReceiveData(SnowMessage snowMessage) {
    SLog.i("_onReceiveData snowMessage:${snowMessage.type.name}");
    _inHead.handle(this, snowMessage);
  }

  write(Uint8List data) {
    _socket.add(data);
  }

  sendSnowMessage(SnowMessage snowMessage) {
    SLog.i("sendSnowMessage: ${snowMessage.type.name}");
    _outHead.encodeSend(this, snowMessage);
  }

  sendCustomMessage(CustomMessage customMessage, SendBlock sendBlock, Prepare prepare) async {
    SLog.i("sendCustomMessage: ${customMessage.type}");
    Int64 cid = SnowIMUtils.generateCid();
    customMessage.cid = cid.toInt();
    addWaitAck(cid, (status, sendingMessage) {
      if (status == SendStatus.SUCCESS) {
        String conversationId = sendingMessage.conversationId;
        sendingMessage.targetId = customMessage.targetId;
        ConversationType conversationType = customMessage.conversationType;
        SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().insertOrUpdateConversationBySend(conversationId, conversationType, sendingMessage);
      }
      sendBlock(status, sendingMessage);
    });
    SnowMessage snowMessage = await _buildSnowMessage(customMessage, prepare);
    _outHead.encodeSend(this, snowMessage);
  }

  Future<SnowMessage> _buildSnowMessage(CustomMessage customMessage, Prepare prepare) async {
    customMessage.id = customMessage.cid;
    customMessage.uid = selfUid;
    customMessage.status = SendStatus.SENDING;
    customMessage.direction = Direction.SEND;
    customMessage.time = SnowIMUtils.currentTime();
    MessageContent messageContent = MessageContent();
    messageContent.uid = selfUid;
    messageContent.content = customMessage.encode();
    messageContent.time = Int64(SnowIMUtils.currentTime());
    messageContent.type = customMessage.type;
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.cid = Int64(customMessage.cid);
    upDownMessage.fromUid = selfUid;
    if (customMessage.conversationType == ConversationType.SINGLE) {
      upDownMessage.targetUid = customMessage.targetId;
    } else if (customMessage.conversationType == ConversationType.GROUP) {
      upDownMessage.conversationId = customMessage.conversationId;
    }
    onSendStatusChanged(SendStatus.SENDING, customMessage);
    customMessage.status = SendStatus.PERSIST;
    await SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().insertSendMessage(customMessage.targetId, customMessage);
    onSendStatusChanged(SendStatus.PERSIST, customMessage);
    if (prepare != null) {
      customMessage = await prepare(customMessage);
    }
    upDownMessage.groupId = "";
    upDownMessage.conversationType = customMessage.conversationType;
    upDownMessage.content = messageContent;
    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.UpDownMessage;
    snowMessage.upDownMessage = upDownMessage;
    return snowMessage;
  }

  onSendStatusChanged(SendStatus status, CustomMessage sendingMessage) {
    _waitAckMap[Int64(sendingMessage.cid)](status, sendingMessage);
  }

  addInBoundHandler(InboundHandler inboundHandler) {
    InboundChain chain = InboundChain(inboundHandler);
    if (_inHead == null) {
      _inHead = chain;
      _inTail = chain;
    } else {
      _inTail.next = chain;
      _inTail = chain;
    }
  }

  addOutBoundEncoder(OutboundEncoder outboundEncoder) {
    if (_outHead == null) {
      _outHead = outboundEncoder;
      _outTail = outboundEncoder;
    } else {
      _outTail.next = outboundEncoder;
      _outTail = outboundEncoder;
    }
  }

  _sendLogin(String token, String uid) {
    SLog.i("_sendLogin");
    Login login = Login();
    login.token = token;
    login.id = SnowIMUtils.generateCid();
    login.uid = uid;
    SnowMessage message = SnowMessage();
    message.type = SnowMessage_Type.Login;
    message.login = login;
    sendSnowMessage(message);
  }

  onLoginSuccess() async {
    SnowDataFetchHelper.getInstance().init(this);
    SnowDataFetchHelper.getInstance().fetchConversationList();
  }

  onLoginFailed(Code code, String msg) {}

  addWaitAck(Int64 cid, SendBlock block) {
    _waitAckMap[cid] = block;
  }

  onMessageAck(Int64 cid, Code code) {
    _waitAckMap.remove(cid);
  }
}
