import 'package:imlib/data/db/dao/snow_im_group_member_dao.dart';
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/data/db/snow_im_db_helper.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SnowIMGroupDao extends SnowIMGroupMemberDao {
  SnowIMGroupDao(Database database) : super(database);

  Future saveGroupEntity(GroupEntity it) async {
    await database.rawInsert(
        "INSERT OR REPLACE INTO ${SnowIMDBHelper.TABLE_GROUP}"
        " (${SnowIMDBHelper.TABLE_GROUP_COLUMN_GROUP_ID},"
        " ${SnowIMDBHelper.TABLE_GROUP_COLUMN_NAME},"
        " ${SnowIMDBHelper.TABLE_GROUP_COLUMN_PORTRAIT},"
        " ${SnowIMDBHelper.TABLE_GROUP_COLUMN_CONVERSATION_ID},"
        " ${SnowIMDBHelper.TABLE_GROUP_COLUMN_STATUS},"
        " ${SnowIMDBHelper.TABLE_GROUP_COLUMN_UPDATE_DATA})"
        " VALUES(?,?,?,?,?,?)",
        [it.groupId, it.detail.name, it.detail.portrait, it.conversationId, 0, it.time]);
  }

  Future<GroupEntity> getGroupEntityByGroupId(String groupId) async {
    SLog.i("SnowIMGroupDao getGroupEntityByGroupId groupId:$groupId");
    List<Map<String, dynamic>> map = await database.rawQuery("SELECT * FROM ${SnowIMDBHelper.TABLE_GROUP} WHERE ${SnowIMDBHelper.TABLE_GROUP_COLUMN_GROUP_ID} = ?", [groupId]);
    if (map == null || map.isEmpty) return null;
    return _convertGroup(map.first);
  }

  Future<GroupEntity> getGroupDetailByConversationId(String conversationId) async {
    List<Map<String, dynamic>> map = await database.rawQuery("SELECT * FROM ${SnowIMDBHelper.TABLE_GROUP} WHERE ${SnowIMDBHelper.TABLE_GROUP_COLUMN_CONVERSATION_ID} = ?", [conversationId]);
    if (map == null || map.isEmpty) return null;
    return _convertGroup(map.first);
  }

  GroupEntity _convertGroup(Map<String, dynamic> map) {
    GroupEntity groupEntity = GroupEntity();
    groupEntity.groupId = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_GROUP_ID];
    groupEntity.conversationId = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_CONVERSATION_ID];
    groupEntity.time = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_UPDATE_DATA];
    GroupDetail detail = GroupDetail();
    detail.groupId = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_GROUP_ID];
    detail.name = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_NAME];
    detail.portrait = map[SnowIMDBHelper.TABLE_GROUP_COLUMN_PORTRAIT];
    groupEntity.detail = detail;
    return groupEntity;
  }
}
