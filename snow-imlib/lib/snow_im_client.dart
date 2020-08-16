import 'dart:async';
import 'dart:io';

import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/rest.dart';

class SnowIMClient {
  static SnowIMClient _instance;

  SnowIMClient._();

  Socket _socket;
  StreamController<ConnectStatus> _connectStreamController = StreamController();
  static SnowIMClient getInstance() {
    if (_instance == null) {
      _instance = SnowIMClient._();
    }
    return _instance;
  }

  StreamController<ConnectStatus>  getController(){
    return _connectStreamController;
  }

  Future<bool> connect(String token) async {
    _connectStreamController.sink.add(ConnectStatus.IDLE);
    _connectStreamController.sink.add(ConnectStatus.CONNECTING);
    HostInfo hostInfo = await HostHelper().getHost(token);
    print("SnowIMClient token:{$token} connect host: {$hostInfo}");
    if (hostInfo != null) {
      return _connect(hostInfo.host, hostInfo.port);
    }
    return false;
  }

  Future<bool> _connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    _connectStreamController.sink.add(ConnectStatus.CONNECTED);
    _socket.listen(_onReceiveData, onDone: _onDone, onError: _onError);
    return true;
  }

  disConnect() {
    _socket.close();
    _socket = null;
    _connectStreamController.sink.add(ConnectStatus.IDLE);
  }

  _onReceiveData(data) {
    print("_onReceiveData length:${data.length}");
  }

  _onDone() {
    print("onDone()");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  _onError(e) {
    print("onError e:$e");
    _connectStreamController.sink.add(ConnectStatus.DISCONNECTED);
  }

  _sendMessage(SnowMessage snowMessage) {

  }
}

enum ConnectStatus { IDLE, CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED }
