import 'package:snowclient/data/db/dao/dao.dart';
import 'package:snowclient/data/db/db_helper.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/generated/json/base/json_convert_content.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserDao extends Dao {
  UserDao(Database database) : super(database);

  Future<List<UserEntity>> getAllUserList() async {
    List<Map<String, dynamic>> map = await database.rawQuery("SELECT * FROM ${DBHelper.TABLE_USER}", null);
    if (map == null) return null;
    return map.map<UserEntity>((e) {
      return JsonConvert.fromJsonAsT<UserEntity>(e);
    }).toList();
  }

  Future<UserEntity> getUserById(String uid) async {
    List<Map<String, dynamic>> map = await database.rawQuery("SELECT * FROM ${DBHelper.TABLE_USER} WHERE ${DBHelper.TABLE_USER_COLUMN_UID} = ?", [uid]);
    if (map == null) return null;
    List<UserEntity> list = map.map<UserEntity>((e) {
      return JsonConvert.fromJsonAsT<UserEntity>(e);
    }).toList();
    return list.first;
  }

  Future saveUserList(List<UserEntity> userList) async {
    await database.transaction((txn) async {
      userList.forEach((it) {
        database.rawInsert(
            "INSERT OR REPLACE INTO ${DBHelper.TABLE_USER}"
            " (${DBHelper.TABLE_USER_COLUMN_UID},"
            " ${DBHelper.TABLE_USER_COLUMN_USER_NAME},"
            " ${DBHelper.TABLE_USER_COLUMN_CREATE_DATA},"
            " ${DBHelper.TABLE_USER_COLUMN_UPDATE_DATA},"
            " ${DBHelper.TABLE_USER_COLUMN_NAME},"
            " ${DBHelper.TABLE_USER_COLUMN_STATE},"
            " ${DBHelper.TABLE_USER_COLUMN_PORTRAIT},"
            " ${DBHelper.TABLE_USER_COLUMN_TYPE})"
            " VALUES(?,?,?,?,?,?,?,?)",
            [it.uid, it.username, it.createDt, it.updateDt, it.name, it.state, it.portrait, it.type]);
      });
    });
  }
}
