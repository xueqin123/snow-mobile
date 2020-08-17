import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:imlib/core/inbound/auth_handler.dart';
import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/rest.dart';
import 'package:imlib/utils/snow_im_utils.dart';

import 'core/inbound/heart_beat_handler.dart';
import 'core/inbound/inbound_chain.dart';
import 'core/inbound/protobuf_varint_32_frame_decoder.dart';
import 'core/inbound/snow_message_decoder.dart';
import 'core/outbound/protobuf_varint_32_length_field_prepender.dart';
import 'core/outbound/snow_message_encoder.dart';

class SnowIMContext {
  static SnowIMContext _instance;

  SnowIMContext._();

  Socket _socket;

  InboundChain head;
  InboundChain tail;

  // ignore: close_sinks
  StreamController<ConnectStatus> _connectStreamController = StreamController();
  ProtobufVarint32FrameDecoder protobufVarint32FrameDecoder = ProtobufVarint32FrameDecoder();
  ProtobufVarint32LengthFieldPrepender _protobufVarint32LengthFieldPrepender = ProtobufVarint32LengthFieldPrepender();
  SnowMessageDecoder snowMessageDecoder = new SnowMessageDecoder();
  SnowMessageEncoder snowMessageEncoder = new SnowMessageEncoder();

  static SnowIMContext getInstance() {
    if (_instance == null) {
      _instance = SnowIMContext._();
    }
    _instance.addInBoundHandler(AuthHandler());
    _instance.addInBoundHandler(HeardBeatHandler());
    return _instance;
  }

  StreamController<ConnectStatus> getController() {
    return _connectStreamController;
  }

  connect(String token, String uid) async {
    _connectStreamController.sink.add(ConnectStatus.IDLE);
    _connectStreamController.sink.add(ConnectStatus.CONNECTING);
    HostInfo hostInfo = await HostHelper().getHost(token);
    print("SnowIMClient token:{$token} connect host: {$hostInfo}");
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
        _onReceiveData(snowMessageDecoder.decode(element));
      });
    }, onDone: _onDone, onError: _onError);
  }

  loginSuccess() {}

  loginFailed(Code code, String msg) {}

  disConnect() {
    _socket.close();
    _socket = null;
    _connectStreamController.sink.add(ConnectStatus.IDLE);
  }

  _onReceiveData(SnowMessage snowMessage) {
    print("_onReceiveData snowMessage:${snowMessage.type.name}");
    head.handle(this, snowMessage);
  }

  _onDone() {
    print("onDone()");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  _onError(e) {
    print("onError e:$e");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  write(SnowMessage snowMessage) {
    print("write message ${snowMessage.type.name}");
    Uint8List messageData = snowMessageEncoder.encode(snowMessage);
    Uint8List totalData = _protobufVarint32LengthFieldPrepender.encode(messageData);
    _socket.add(totalData);
  }

  addInBoundHandler(InboundHandler inboundHandler) {
    InboundChain chain = InboundChain(inboundHandler);
    if (head == null) {
      head = chain;
      tail = chain;
    }
    tail.next = chain;
  }

  _sendLogin(String token, String uid) {
    Login login = Login();
    login.token = token;
    login.id = SnowIMUtils.generateMessageId();
    login.uid = uid;
    SnowMessage message = SnowMessage();
    message.type = SnowMessage_Type.Login;
    message.login = login;
    write(message);
  }
}

enum ConnectStatus { IDLE, CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED }
