import 'dart:async';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/imlib.dart';

class SnowIMConnectManager {
  String token;
  SnowIMContext context;

  SnowIMConnectManager._();

  // ignore: close_sinks
  StreamController<ConnectStatus> _connectStreamController = StreamController();
  static SnowIMConnectManager _instance;

  static SnowIMConnectManager getInstance() {
    if (_instance == null) {
      _instance = SnowIMConnectManager._();
    }
    return _instance;
  }

  init(SnowIMContext context, String token) {
    this.token = token;
    this.context = context;
  }

  connect() async {
    _onStatusChanged(ConnectStatus.IDLE);
    _onStatusChanged(ConnectStatus.DISCONNECTING);
    await context.connect(token);
    _onStatusChanged(ConnectStatus.CONNECTED);
  }

  disConnect() async {
    await context.disConnect();
    _onStatusChanged(ConnectStatus.DISCONNECTED);
  }

  _onStatusChanged(ConnectStatus connectStatus) {
    SLog.i("SnowIMConnectManager _onStatusChanged() connectStatus :$connectStatus");
    _connectStreamController.sink.add(connectStatus);
  }

  StreamController<ConnectStatus> getConnectStatusController() {
    return _connectStreamController;
  }

  onSocketError(Exception exception) {
    SLog.i("SnowIMConnectManager onSocketError() exception:$exception");
    _onStatusChanged(ConnectStatus.DISCONNECTED);
  }

  onSocketDone() {
    SLog.i("SnowIMConnectManager onSocketDone()");
    _onStatusChanged(ConnectStatus.DISCONNECTED);
  }
}
