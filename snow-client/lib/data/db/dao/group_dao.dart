import 'package:snowclient/data/db/dao/dao.dart';
import 'package:sqflite_common/sqlite_api.dart';

class GroupDao extends Dao{
  GroupDao(Database database, String currentUid) : super(database, currentUid);

}