import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/entity/req_user_entity.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/notifier.dart';
import 'package:snowclient/data/model/base_model.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/service/upload_service.dart';
import 'package:snowclient/rest/service/user_service.dart';

class ContactModel extends BaseModel {
  UserDao _userDao;
  UserService _userService;
  UploadService _uploadService;
  List<Notifier> _notifierList = List();

  ContactModel() {
    _userDao = DaoManager.getInstance().getDao<UserDao>();
    _userService = HttpManager.getInstance().getService<UserService>();
    _uploadService = HttpManager.getInstance().getService<UploadService>();
  }

  StreamController<List<UserEntity>> getAllUserController() {
    UserAllNotifier notifier = UserAllNotifier();
    _notifierList.add(notifier);
    _updateAllUsersFromServer();
    return notifier.streamController;
  }

  Future<List<UserEntity>> getAllUserList() async {
    return _userDao.getAllUserList();
  }

  UserEntity getCurrentUser() {
    return _userDao.currentUser;
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

  Future upDataUserPortrait(String uid, String path) async {
    String url = await _uploadService.upLoadImage(path);
    ReqUserEntity reqUserEntity = ReqUserEntity();
    reqUserEntity.portrait = url;
    bool isSuccess = await _userService.updateUserByUid(uid, reqUserEntity);
    _updateAllUsersFromServer();
    return isSuccess;
  }

  _postStreamData() {
    _notifierList.removeWhere((element) => element.streamController.isClosed);
    SLog.i("ContactModel _notifyChange() rest of controller size: ${_notifierList.length}");
    _notifierList.forEach((element) {
      element.post();
    });
  }

  Future<UserEntity> getUserById(String uid) async {
    UserDao userDao = DaoManager.getInstance().getDao<UserDao>();
    return userDao.getUserById(uid);
  }
}

class UserAllNotifier extends Notifier<List<UserEntity>> {
  @override
  Future post() async {
    UserDao userDao = DaoManager.getInstance().getDao<UserDao>();
    List<UserEntity> userList = await userDao.getAllUserList();
    if (userList != null && !streamController.isClosed) {
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
    if (userEntity != null && !streamController.isClosed) {
      streamController.sink.add(userEntity);
    }
  }
}
