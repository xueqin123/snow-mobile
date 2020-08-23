import 'dart:ffi';

import 'package:imlib/data/db/dao/snow_im_dao.dart';
import 'package:imlib/data/db/entity/conversation_entity.dart';
import 'package:imlib/data/db/snow_im_db_helper.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SnowIMConversationDao extends SnowIMDao {
  SnowIMConversationDao(Database database) : super(database);

  saveConversationList(List<ConversationInfo> conversationList) async {
    List<Conversation> list = conversationList.map((e) => _convert(e)).toList();
    Batch batch = database.batch();
    list.forEach((it) {
      batch.rawInsert(
          "INSERT OR REPLACE INTO ${SnowIMDBHelper.TABLE_CONVERSATION}"
          " (${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_CONVERSATION_ID},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TYPE},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_UID_LIST},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_GROUP_ID},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_READ_MESSAGE_ID},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_ID},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_UID},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TYPE},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_CONTENT},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TIME},"
          " ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TIME})"
          " VALUES(?,?,?,?,?,?,?,?,?,?,?)",
          [it.conversationId, it.type.value, it.getUidListString(), it.groupId, it.readMsgId, it.lastId, it.lastUid, it.lastType, it.lastContent, it.lastTime, it.time]);
    });
    await batch.commit();
  }

  saveConversation(ConversationInfo conversationInfo) async {
    await saveConversationList(<ConversationInfo>[conversationInfo]);
  }

  Future<List<Conversation>> getConversationAllList() async {
    List<Map<String, dynamic>> mapList = await database.rawQuery("SELECT * FROM ${SnowIMDBHelper.TABLE_CONVERSATION}", null);
    if (mapList == null) return null;
    return mapList.map((e) => _convertMap(e)).toList();
  }

  Future<Conversation> getSingleConversationTarget(String targetId) async {
    List<Map<String, dynamic>> mapList = await database.rawQuery(
        "SELECT * FROM "
        "${SnowIMDBHelper.TABLE_CONVERSATION} "
        "WHERE ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TYPE} = ? "
        "AND ${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_UID_LIST} LIKE ?",
        [ConversationType.SINGLE.value, "%" + targetId + "%"]);
    if (mapList == null || mapList.isEmpty) return null;
    var item = mapList.first;
    return _convertMap(item);
  }

  Future<Conversation> getConversationByConversationId(String conversationId) async {
    List<Map<String, dynamic>> mapList = await database.rawQuery(
        "SELECT * FROM "
        "${SnowIMDBHelper.TABLE_CONVERSATION} "
        "WHERE "
        "${SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_CONVERSATION_ID} = ?",
        [conversationId]);
    if (mapList == null || mapList.isEmpty) return null;
    var item = mapList.first;
    return _convertMap(item);
  }

  Conversation _convert(ConversationInfo conversationInfo) {
    Conversation temp = Conversation();
    temp.conversationId = conversationInfo.conversationId;
    temp.type = conversationInfo.type;
    temp.uidList = conversationInfo.uidList;
    temp.groupId = conversationInfo.groupId;
    temp.readMsgId = conversationInfo.readMsgId.toString();
    temp.lastId = conversationInfo.lastContent.id.toString();
    temp.lastUid = conversationInfo.lastContent.uid;
    temp.lastType = conversationInfo.lastContent.type;
    temp.lastContent = conversationInfo.lastContent.content;
    temp.lastTime = conversationInfo.lastContent.time.toInt();
    temp.time = conversationInfo.time.toInt();
    return temp;
  }

  Conversation _convertMap(Map<String, dynamic> map) {
    Conversation temp = Conversation();
    temp.conversationId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_CONVERSATION_ID];
    temp.type = ConversationType.valueOf(map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TYPE]);
    temp.setUidListString(map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_UID_LIST]);
    temp.groupId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_GROUP_ID];
    temp.readMsgId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_READ_MESSAGE_ID];
    temp.lastId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_ID];
    temp.lastUid = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_UID];
    temp.lastType = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TYPE];
    temp.lastContent = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_CONTENT];
    temp.lastTime = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TIME];
    temp.time = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TIME];
    return temp;
  }
}
