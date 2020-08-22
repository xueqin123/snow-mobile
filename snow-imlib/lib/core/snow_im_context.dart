import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:imlib/core/inbound/handler/conversation_handler.dart';
import 'package:imlib/core/inbound/handler/history_message_handler.dart';
import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/model/snow_conversation_model.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/data/db/model/snow_message_model.dart';
import 'package:imlib/data/db/snow_im_db_helper.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/rest.dart';
import 'package:imlib/rest/snow_fetch_helper.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

import 'inbound/handler/auth_handler.dart';
import 'inbound/handler/heart_beat_handler.dart';
import 'inbound/handler/message_ack_handler.dart';
import 'inbound/handler/message_handler.dart';
import 'inbound/inbound_chain.dart';
import 'inbound/protobuf_varint_32_frame_decoder.dart';
import 'inbound/snow_message_decoder.dart';
import 'outbound/encoder/custom_message_encoder.dart';
import 'outbound/encoder/protobuf_varint_32_length_field_prepender.dart';
import 'outbound/encoder/snow_message_encoder.dart';

class SnowIMContext {
  static SnowIMContext _instance;
  String selfUid;

  SnowIMContext._();

  Socket _socket;

  InboundChain _inHead;
  InboundChain _inTail;
  OutboundEncoder _outHead;
  OutboundEncoder _outTail;
  OutboundEncoder _outSnowHead;

  // ignore: close_sinks
  StreamController<ConnectStatus> _connectStreamController = StreamController();

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

    _instance.addOutBoundEncoder(CustomMessageEncoder());
    _instance.addOutBoundEncoder(SnowMessageEncoder());
    _instance.addOutBoundEncoder(ProtobufVarint32LengthFieldPrepender());
    return _instance;
  }

  StreamController<ConnectStatus> getConnectStatusController() {
    return _connectStreamController;
  }

  StreamController<CustomMessage> getCustomMessageController() {
    return _customMessageStreamController;
  }

  StreamController<List<Conversation>> getConversationListController() {
    return SnowIMModelManager.getInstance().getModel<SnowConversationModel>().getConversationController();
  }

  connect(String token) async {
    _connectStreamController.sink.add(ConnectStatus.IDLE);
    _connectStreamController.sink.add(ConnectStatus.CONNECTING);
    HostInfo hostInfo = await HostHelper().getHost(token);
    SLog.i("SnowIMContext token:{$token} connect host: {$hostInfo}");
    if (hostInfo != null) {
      await _connect(hostInfo.host, hostInfo.port);
      _sendLogin(token, selfUid);
    }
  }

  //connect 之前先init
  init(String uid) async {
    _initDB(uid);
  }

  _initDB(String uid) async {
    selfUid = uid;
    await SnowIMDaoManager.getInstance().init(selfUid);
  }

  _connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    _connectStreamController.sink.add(ConnectStatus.CONNECTED);
    _socket.listen((event) {
      SLog.v("socket listen event:${event.length}");
      List<Uint8List> packages = protobufVarint32FrameDecoder.decode(event);
      packages.forEach((element) {
        _onReceiveData(_snowMessageDecoder.decode(element));
      });
    }, onDone: _onConnectDone, onError: _onConnectError);
  }

  disConnect() {
    _socket.close();
    _socket = null;
    _connectStreamController.sink.add(ConnectStatus.IDLE);
  }

  _onReceiveData(SnowMessage snowMessage) {
    SLog.i("_onReceiveData snowMessage:${snowMessage.type.name}");
    _inHead.handle(this, snowMessage);
  }

  _onConnectDone() {
    SLog.i("onDone()");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  _onConnectError(e) {
    SLog.i("onError e:$e");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  write(Uint8List data) {
    _socket.add(data);
  }

  sendSnowMessage(SnowMessage snowMessage) {
    SLog.i("sendSnowMessage: ${snowMessage.type.name}");
    _outSnowHead.encodeSend(this, snowMessage);
  }

  sendCustomMessage(CustomMessage customMessage, SendBlock sendBlock) {
    SLog.i("sendCustomMessage: ${customMessage.type}");
    Int64 cid = SnowIMUtils.generateCid();
    customMessage.cid = cid.toInt();
    addWaitAck(cid, sendBlock);
    _outHead.encodeSend(this, customMessage);
  }

  onSendStatusChanged(SendStatus status, CustomMessage customMessage) {
    _waitAckMap[Int64(customMessage.cid)](status,customMessage);
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
    if (outboundEncoder is SnowMessageEncoder) {
      _outSnowHead = outboundEncoder;
    }
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

  onLoginSuccess() {
    SnowAckHelper.getInstance().init(this);
    SnowAckHelper.getInstance().fetchConversationList();
  }

  onLoginFailed(Code code, String msg) {}

  addWaitAck(Int64 cid, SendBlock block) {
    _waitAckMap[cid] = block;
  }

  onMessageAck(Int64 cid, Code code) {
    _waitAckMap.remove(cid);
  }
}

enum ConnectStatus { IDLE, CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED }
