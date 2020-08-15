import 'dart:async';

import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/notifier.dart';
import 'package:snowclient/data/model/snow_model.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/service/user_service.dart';

class ContactModel extends SnowModel {
  UserDao _userDao;
  UserService _userService;
  List<Notifier> _notifierList = List();

  ContactModel() {
    _userDao = DaoManager.getInstance().getDao<UserDao>();
    _userService = HttpManager.getInstance().getService<UserService>();
  }

  StreamController<List<UserEntity>> getAllUserController() {
    UserAllNotifier notifier = UserAllNotifier();
    _notifierList.add(notifier);
    _updateAllUsersFromServer();
    return notifier.streamController;
  }

  StreamController<UserEntity> getUserController(String uid) {
    UserNotifier notifier = UserNotifier(uid);
    _notifierList.add(notifier);
    _updateUserFromServer(uid);
    return notifier.streamController;
  }

  Future _updateAllUsersFromServer() async {
    _postStreamData();
    await syncUserData();
    _postStreamData();
  }

  Future syncUserData() async {
    List<UserEntity> userList = await _userService.getAllUserList();
    await _userDao.saveUserList(userList);
  }

  Future _updateUserFromServer(String uid) async {
    _postStreamData();
    UserEntity userEntity = await _userService.getUserByUid(uid);
    await _userDao.saveUserList(<UserEntity>[userEntity]);
    _postStreamData();
  }

  _postStreamData() {
    _notifierList.removeWhere((element) => element.streamController.isClosed);
    print("ContactModel _notifyChange() rest of controller size: ${_notifierList.length}");
    _notifierList.forEach((element) {
      element.post();
    });
  }
}

class UserAllNotifier extends Notifier<List<UserEntity>> {
  @override
  Future post() async {
    UserDao userDao = DaoManager.getInstance().getDao<UserDao>();
    List<UserEntity> userList = await userDao.getAllUserList();
    if (userList != null) {
      streamController.sink.add(userList);
    }
  }
}

class UserNotifier extends Notifier<UserEntity> {
  String uid;

  UserNotifier(this.uid);

  @override
  Future post() async {
    UserDao userDao = DaoManager.getInstance().getDao<UserDao>();
    UserEntity userEntity = await userDao.getUserById(uid);
    if (userEntity != null) {
      streamController.sink.add(userEntity);
    }
  }
}
