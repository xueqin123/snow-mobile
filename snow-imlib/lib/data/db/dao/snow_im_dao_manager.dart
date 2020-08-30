import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao.dart';
import 'package:imlib/data/db/dao/snow_im_group_dao.dart';
import 'package:imlib/data/db/dao/snow_im_message_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../snow_im_db_helper.dart';

class SnowIMDaoManager {
  static final SnowIMDaoManager _instance = SnowIMDaoManager();
  Map<String, SnowIMDao> _daoMaps;

  static SnowIMDaoManager getInstance() {
    return _instance;
  }

  Future init(String uid) async {
    _daoMaps = Map();
    Database database = await SnowIMDBHelper.getInstance().openDB(uid);
    _initDao(database);
  }

  _initDao(Database database) {
    _putDao(SnowIMConversationDao(database));
    _putDao(SnowIMMessageDao(database));
    _putDao(SnowIMGroupDao(database));
  }

  void _putDao(SnowIMDao dao) {
    _daoMaps[dao.runtimeType.toString()] = dao;
  }

  T getDao<T>() {
    return _daoMaps[T.toString()] as T;
  }
}
