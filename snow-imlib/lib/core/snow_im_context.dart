import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/core/outbound/outbound_encoder_chain.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/rest.dart';
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
  OutboundChain _outHead;
  OutboundChain _outTail;
  OutboundChain _outSnowHead;

  // ignore: close_sinks
  StreamController<ConnectStatus> _connectStreamController = StreamController();

  // ignore: close_sinks
  StreamController<CustomMessage> _customMessageStreamController = StreamController.broadcast();


  ProtobufVarint32FrameDecoder protobufVarint32FrameDecoder = ProtobufVarint32FrameDecoder();
  SnowMessageDecoder _snowMessageDecoder = new SnowMessageDecoder();
  Map<Int64, SendBlock> _waitAckMap = LinkedHashMap();

  static SnowIMContext getInstance() {
    if (_instance == null) {
      _instance = SnowIMContext._();
    }
    _instance.addInBoundHandler(AuthHandler());
    _instance.addInBoundHandler(HeardBeatHandler());
    _instance.addInBoundHandler(MessageHandler());
    _instance.addInBoundHandler(MessageAckHandler());

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

  connect(String token, String uid) async {
    selfUid = uid;
    _connectStreamController.sink.add(ConnectStatus.IDLE);
    _connectStreamController.sink.add(ConnectStatus.CONNECTING);
    HostInfo hostInfo = await HostHelper().getHost(token);
    SLog.i("SnowIMContext token:{$token} connect host: {$hostInfo}");
    if (hostInfo != null) {
      await _connect(hostInfo.host, hostInfo.port);
      _sendLogin(token, uid);
    }
  }

  _connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    _connectStreamController.sink.add(ConnectStatus.CONNECTED);
    _socket.listen((event) {
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

  _write(Uint8List data) {
    _socket.add(data);
  }

  sendSnowMessage(SnowMessage snowMessage) {
    SLog.i("sendSnowMessage: ${snowMessage.type.name}");
    _write(_outSnowHead.encode(this, snowMessage));
  }

  sendCustomMessage(CustomMessage customMessage, SendBlock sendBlock) {
    SLog.i("sendCustomMessage: ${customMessage.type}");
    _write(_outHead.encode(this, customMessage));
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
    OutboundChain chain = OutboundChain(outboundEncoder);
    if (outboundEncoder is SnowMessageEncoder) {
      _outSnowHead = chain;
    }
    if (_outHead == null) {
      _outHead = chain;
      _outTail = chain;
    } else {
      _outTail.next = chain;
      _outTail = chain;
    }
  }

  _sendLogin(String token, String uid) {
    SLog.i("_sendLogin");
    Login login = Login();
    login.token = token;
    login.id = SnowIMUtils.currentTime();
    login.uid = uid;
    SnowMessage message = SnowMessage();
    message.type = SnowMessage_Type.Login;
    message.login = login;
    sendSnowMessage(message);
  }

  onLoginSuccess() {}

  onLoginFailed(Code code, String msg) {}

  addWaitAck(Int64 cid, SendBlock block) {
    block(SendStatus.SENDING);
    _waitAckMap[cid] = block;
  }

  onMessageAck(Int64 cid, Code code) {
    SendBlock block = _waitAckMap[cid];
    if (block == null) {
      return;
    }
    if (code == Code.SUCCESS) {
      block(SendStatus.SUCCESS);
    } else {
      block(SendStatus.FAILED);
    }
    _waitAckMap.remove(cid);
  }
}

enum ConnectStatus { IDLE, CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED }
