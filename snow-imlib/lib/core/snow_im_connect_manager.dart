import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/imlib.dart';

class SnowIMConnectManager {
  String token;
  SnowIMContext context;

  SnowIMConnectManager._();

  ConnectStatus curStatus = ConnectStatus.IDLE;

  // ignore: close_sinks
  StreamController<ConnectStatus> _connectStreamController = StreamController();
  StreamSubscription subscription;
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
    initNetListener();
  }

  connect() async {
    _onStatusChanged(ConnectStatus.IDLE);
    _onStatusChanged(ConnectStatus.CONNECTING);
    await context.connect(token);
    _onStatusChanged(ConnectStatus.CONNECTED);
  }

  disConnect() async {
    await context.disConnect();
    _onStatusChanged(ConnectStatus.IDLE);
  }

  _onStatusChanged(ConnectStatus connectStatus) {
    SLog.i("SnowIMConnectManager _onStatusChanged() connectStatus :$connectStatus");
    curStatus = connectStatus;
    _connectStreamController.sink.add(connectStatus);
    if (connectStatus == ConnectStatus.DISCONNECTED) {
      Future.delayed(Duration(seconds: 3)).then((value) => {_tryReconnect("Status Disconnect Delay 3 second")});
    }
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

  initNetListener() {
    subscription = new Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      SLog.i("native connect changed ConnectivityResult: $result");
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        _tryReconnect("onConnectivityChanged");
      }
    });
  }

  _tryReconnect(String log) async {
    if (curStatus == ConnectStatus.DISCONNECTED) {
      var result = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        SLog.i("_tryReconnect reason: $log");
        connect();
      }
    }
  }
}
