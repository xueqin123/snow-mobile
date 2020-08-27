import 'package:imlib/data/db/dao/snow_im_group_member_dao.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SnowIMGroupDao extends SnowIMGroupMemberDao{
  SnowIMGroupDao(Database database) : super(database);
}