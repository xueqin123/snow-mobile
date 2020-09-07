import 'dart:async';

import 'package:imlib/imlib.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  UnreadCount initData = UnreadCount();
  StreamController<UnreadCount> _unReadCountController;
  StreamController<ConnectStatus> _connectStatusController;
  ConnectStatus current = ConnectStatus.IDLE;

  HomeModel() {
    SnowIMLib.getTotalUnReadCountStream().listen((event) {
      SLog.i("HomeModel getTotalUnReadCountStream event:$event");
      initData.MessageUnReadCount = event;
      if (_unReadCountController != null) {
        UnreadCount unreadCount = UnreadCount();
        unreadCount.MessageUnReadCount = event;
        if (_unReadCountController == null || _unReadCountController.isClosed) {
          _unReadCountController = null;
        } else {
          _unReadCountController.sink.add(unreadCount);
        }
      }
    });
    SnowIMLib.getConnectStatusStream().listen((event) {
      SLog.i("HomeModel getConnectStatusStream: $event");
      current = event;
      if (_connectStatusController != null && !_connectStatusController.isClosed) {
        _connectStatusController.sink.add(event);
      }
    });
  }

  StreamController<UnreadCount> getTotalUnReadController() {
    _unReadCountController = StreamController<UnreadCount>();
    _unReadCountController.sink.add(initData);
    return _unReadCountController;
  }

  StreamController<ConnectStatus> getConnedStreamController() {
    _connectStatusController = StreamController();
    _connectStatusController.sink.add(current);
    return _connectStatusController;
  }
}

class UnreadCount {
  int MessageUnReadCount = 0;
  int ContactUnReadCount = 0;
  int discoveryUnReadCount = 0;
  int mineUnReadCount = 0;
}
