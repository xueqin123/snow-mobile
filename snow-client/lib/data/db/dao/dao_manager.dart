import 'package:imlib/imlib.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class DaoManager {
  static final DaoManager _instance = DaoManager();
  Map<String, Dao> _daoMaps;

  String _currentUid;
  get currentUid => _currentUid;
  static DaoManager getInstance() {
    return _instance;
  }

  Future init(String uid) async {
    _daoMaps = Map();
    Database database = await DBHelper.getInstance().openDB(uid);
    _initDao(database,uid);
    SLog.i("DaoManager init success");
  }

  _initDao(Database database,String currentUid) {
    UserDao userDao = UserDao(database,currentUid);
    _daoMaps[userDao.runtimeType.toString()] = userDao;
  }


  T getDao<T>() {
    return _daoMaps[T.toString()] as T;
  }
}
