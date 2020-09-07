import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:imlib/imlib.dart';
import 'package:snowclient/data/model/homeModel.dart';
import 'package:snowclient/data/model/model_manager.dart';

class HomeViewModel extends ChangeNotifier {

  StreamController<UnreadCount> getTotalUnReadCountController() {
    return ModelManager.getInstance().getModel<HomeModel>().getTotalUnReadController();
  }

  StreamController<ConnectStatus> getConnectStatusController(){
    return ModelManager.getInstance().getModel<HomeModel>().getConnedStreamController();
  }
}
