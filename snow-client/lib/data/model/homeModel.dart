import 'dart:async';

import 'package:imlib/imlib.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  UnreadCount initData = UnreadCount();
  StreamController<UnreadCount> _unReadCountController;

  HomeModel() {
    SnowIMLib.getTotalUnReadCountStream().listen((event) {
      SLog.i("HomeModel getTotalUnReadCountStream event:$event");
      initData.MessageUnReadCount = event;
      if (_unReadCountController != null) {
        UnreadCount unreadCount = UnreadCount();
        unreadCount.MessageUnReadCount = event;
        if(_unReadCountController == null || _unReadCountController.isClosed){
          _unReadCountController = null;
        }else{
          _unReadCountController.sink.add(unreadCount);
        }
      }
    });
  }

  StreamController<UnreadCount> getTotalUnReadController() {
    _unReadCountController = StreamController<UnreadCount>();
    _unReadCountController.sink.add(initData);
    return _unReadCountController;
  }
}

class UnreadCount {
  int MessageUnReadCount = 0;
  int ContactUnReadCount = 0;
  int discoveryUnReadCount = 0;
  int mineUnReadCount = 0;
}
