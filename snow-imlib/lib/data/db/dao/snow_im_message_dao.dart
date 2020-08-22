import 'dart:convert';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/dao/snow_im_dao.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/message/message_manager.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/snow_im_utils.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../snow_im_db_helper.dart';

class SnowIMMessageDao extends SnowIMDao {
  SnowIMMessageDao(Database database) : super(database);

  saveMessage(SnowMessage snowMessage) {}

  saveSnowMessageList(String conversationId, List<MessageContent> snowMessageList) async {
    Batch batch = database.batch();
    snowMessageList.forEach((it) {
      batch.rawInsert(
          "INSERT OR REPLACE INTO ${SnowIMDBHelper.TABLE_MESSAGE}"
          " (${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS})"
          " VALUES(?,?,?,?,?,?,?)",
          [it.id, it.uid, conversationId, it.type, it.content, it.time, SendStatus.SUCCESS.index]);
    });
    await batch.commit();
  }

  saveSnowMessage(String conversationId, MessageContent messageContent) async {
    await saveSnowMessageList(conversationId, <MessageContent>[messageContent]);
  }

  insertSendMessage(String conversationId, CustomMessage it) async {
    await database.rawInsert(
        "INSERT INTO ${SnowIMDBHelper.TABLE_MESSAGE}"
        " (${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS})"
        " VALUES(?,?,?,?,?,?,?)",
        [it.cid, it.uid, conversationId, it.type, jsonEncode(it.encode()), it.time, it.status.index]);
  }

  updateSendMessage(int messageId, SendStatus status, int cid) async {
    await database.rawUpdate(
        "UPDATE ${SnowIMDBHelper.TABLE_MESSAGE}"
        " SET "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?,"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS} = ?"
        " WHERE "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?",
        [messageId, status.index, cid]);
  }

  Future<List<CustomMessage>> getCustomMessageList(String conversationId, int beginId) async {
    List<Map<String, dynamic>> mapList;
    if (beginId >= 0) {
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
          "WHERE "
          "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
          "AND ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} < ? "
          "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  DESC",
          [conversationId, beginId]);
    } else {
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
          "WHERE "
          "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
          "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  DESC",
          [conversationId]);
    }

    return mapList.map((e) => _convertCustomMessage(e)).toList();
  }

  Future<CustomMessage> getCustomMessageByMessageId(int messageId) async{
    SLog.i("getCustomMessageByMessageId messageId: $messageId");
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE}"
        " WHERE ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?",
        [messageId]);
    SLog.i("getCustomMessageByMessageId maps.length: ${maps.length}");
    if(maps == null || maps.isEmpty){
      return null;
    }
    Map<String, dynamic> map = maps.first;
    return _convertCustomMessage(map);
  }

  CustomMessage _convertCustomMessage(Map<String, dynamic> map) {
    String type = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE];
    CustomMessage readyMessage = MessageManager.getInstance().getMessageProvider(type)();
    readyMessage.id = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID];
    readyMessage.uid = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID];
    readyMessage.type = type;
    readyMessage.targetId = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID];
    readyMessage.decode(jsonDecode(map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT]));
    readyMessage.direction = _getDirection(readyMessage.uid);
    readyMessage.time = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME];
    return readyMessage;
  }

  Direction _getDirection(String sendId) {
    if (sendId == SnowIMContext.getInstance().selfUid) {
      return Direction.SEND;
    } else {
      return Direction.RECEIVE;
    }
  }
}
