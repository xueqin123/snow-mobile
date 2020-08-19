import 'package:imlib/data/db/dao/snow_im_dao.dart';
import 'package:imlib/data/db/entity/conversation_entity.dart';
import 'package:imlib/data/db/snow_im_db_helper.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SnowIMConversationDao extends SnowIMDao {
  SnowIMConversationDao(Database database) : super(database);

  saveConversationList(List<ConversationInfo> conversationList) async {
    List<ConversationEntity> list = conversationList.map((e) => _convert(e)).toList();
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
          [it.conversationId, it.type, it.getUidList(), it.groupId, it.readMsgId, it.lastId, it.lastUid, it.lastType, it.lastContent, it.lastTime, it.time]);
    });
    await batch.commit();
  }

  Future<List<ConversationEntity>> getConversationAllList() async {
    List<Map<String, dynamic>> mapList = await database.rawQuery("SELECT * FROM ${SnowIMDBHelper.TABLE_CONVERSATION}", null);
    if (mapList == null) return null;
    return mapList.map((e) => _convertMap(e)).toList();
  }


  saveConversation(ConversationInfo conversationInfo) async {
    //tod
  }

  ConversationEntity _convert(ConversationInfo conversationInfo) {
    ConversationEntity temp = ConversationEntity();
    temp.conversationId = conversationInfo.conversationId;
    temp.type = conversationInfo.type.value;
    temp.uidList = conversationInfo.uidList;
    temp.groupId = conversationInfo.groupId;
    temp.readMsgId = conversationInfo.readMsgId.toString();
    temp.lastId = conversationInfo.lastContent.id.toString();
    temp.lastUid = conversationInfo.lastContent.uid;
    temp.lastType = conversationInfo.lastContent.type;
    temp.lastContent = conversationInfo.lastContent.content;
    temp.lastTime = conversationInfo.lastContent.time.toString();
    temp.time = conversationInfo.time.toString();
    return temp;
  }

  ConversationEntity _convertMap(Map<String,dynamic> map){
    ConversationEntity temp = ConversationEntity();
    temp.conversationId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_CONVERSATION_ID];
    temp.type = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TYPE];
    temp.setUidList(map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_UID_LIST]);
    temp.groupId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_GROUP_ID];
    temp.readMsgId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_READ_MESSAGE_ID];
    temp.lastId = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_ID];
    temp.lastUid = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_UID];
    temp.lastType = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TYPE];
    temp.lastContent = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_CONTENT];
    temp.lastTime = map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_LAST_TIME];
    temp.time =  map[SnowIMDBHelper.TABLE_CONVERSATION_COLUMN_TIME];
    return temp;
  }
}
