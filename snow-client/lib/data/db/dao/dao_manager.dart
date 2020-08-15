import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class DaoManager {
  static final DaoManager _instance = DaoManager();
  Map<String, Dao> _daoMaps;

  static DaoManager getInstance() {
    return _instance;
  }

  Future init(String uid) async {
    _daoMaps = Map();
    Database database = await DBHelper.getInstance().openDB(uid);
    _initDao(database);
    print("DaoManager init success");
  }

  _initDao(Database database) {
    UserDao userDao = UserDao(database);
    _putDao(userDao);
  }

  void _putDao(Dao dao) {
    _daoMaps[dao.runtimeType.toString()] = dao;
  }

  T getDao<T>() {
    return _daoMaps[T.toString()] as T;
  }
}
