import 'dart:convert';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/dao/snow_im_dao.dart';
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
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME})"
          " VALUES(?,?,?,?,?,?)",
          [it.id, it.uid, conversationId, it.type, it.content, it.time]);
    });
    await batch.commit();
  }

  saveSnowMessage(String conversationId, MessageContent messageContent) async {
    await saveSnowMessageList(conversationId, <MessageContent>[messageContent]);
  }

  Future<List<CustomMessage>> getCustomMessageList(String conversationId, int beginId) async {
    List<Map<String, dynamic>> mapList;
    if(beginId>=0){
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
              "WHERE "
              "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
              "AND ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} < ? "
              "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  DESC",
          [conversationId, beginId]);
    }else{
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
              "WHERE "
              "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
              "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  DESC",
          [conversationId]);
    }

    return mapList.map((e) => _convertCustomMessage(e)).toList();
  }

  CustomMessage _convertCustomMessage(Map<String, dynamic> map) {
    String type = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE];
    CustomMessage readyMessage = MessageManager.getInstance().getMessageProvider(type)();
    readyMessage.id = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID];
    readyMessage.uid = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID];
    readyMessage.type = type;
    readyMessage.content = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT];
    readyMessage.targetId = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID];
    readyMessage.decode(jsonDecode(readyMessage.content));
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
