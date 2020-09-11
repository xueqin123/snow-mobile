import 'dart:convert';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/dao/snow_im_dao.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/message/message_manager.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../snow_im_db_helper.dart';

class SnowIMMessageDao extends SnowIMDao {
  SnowIMMessageDao(Database database) : super(database);

  saveMessage(SnowMessage snowMessage) {}

  saveSnowMessageList(String conversationId, List<MessageContent> snowMessageList, int UnReadCount) async {
    SLog.i("messagelist UnReadCount:$UnReadCount");
    Batch batch = database.batch();
    snowMessageList.sort((a, b) => (b.id.toInt() - a.id.toInt()));
    int index = 0;
    snowMessageList.forEach((it) {
      index++;
      ReadStatus readStatus = ReadStatus.READ;
      if (index <= UnReadCount) {
        readStatus = ReadStatus.UNREAD;
      }
      batch.rawInsert(
          "INSERT OR IGNORE INTO ${SnowIMDBHelper.TABLE_MESSAGE}"
          " (${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS},"
          " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS})"
          " VALUES(?,?,?,?,?,?,?,?)",
          [it.id.toInt(), it.uid, conversationId, it.type, it.content, it.time.toInt(), SendStatus.SUCCESS.index, readStatus.index]);
    });
    await batch.commit();
  }

  saveReceiveSnowMessage(String conversationId, MessageContent it) async {
    await database.rawInsert(
        "INSERT OR REPLACE INTO ${SnowIMDBHelper.TABLE_MESSAGE}"
        " (${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS})"
        " VALUES(?,?,?,?,?,?,?,?)",
        [it.id.toInt(), it.uid, conversationId, it.type, it.content, it.time.toInt(), SendStatus.SUCCESS.index, ReadStatus.UNREAD.index]);
  }

  updateMessageReadStatus(List<int> messageIdList) async {
    if (messageIdList == null || messageIdList.isEmpty) {
      return;
    }
    String placeHolder = "'" + messageIdList.join("','") + "'";
    SLog.i("updateMessageReadStatus placeHolder:$placeHolder");
    if (placeHolder.isEmpty) return;
    await database.rawUpdate(
        "UPDATE ${SnowIMDBHelper.TABLE_MESSAGE}"
        " SET "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS} = ?"
        " WHERE "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} IN ($placeHolder)",
        [ReadStatus.READ.index]);
  }

  insertSendMessage(String toUserId, CustomMessage it) async {
    it.content = it.encode();
    await database.rawInsert(
        "INSERT INTO ${SnowIMDBHelper.TABLE_MESSAGE}"
        " (${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_FROM_UID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_TYPE},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS},"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS})"
        " VALUES(?,?,?,?,?,?,?,?)",
        [it.cid, it.uid, toUserId, it.type, it.content, it.time, it.status.index, ReadStatus.READ.index]);
  }

  updateSendMessage(int messageId, String conversationId, SendStatus status, int cid) async {
    await database.rawUpdate(
        "UPDATE ${SnowIMDBHelper.TABLE_MESSAGE}"
        " SET "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?,"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ?,"
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS} = ?"
        " WHERE "
        " ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?",
        [messageId, conversationId, status.index, cid]);
  }

  Future<int> getUnReadMessageCount(String conversationId) async {
    List<Map<String, dynamic>> list = await database.rawQuery(
        "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
        "WHERE "
        "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
        "AND "
        "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS} = ? ",
        [conversationId, ReadStatus.UNREAD.index]);
    return list == null ? 0 : list.length;
  }

  Future<int> getTotalUnReadMessageCount() async {
    List<Map<String, dynamic>> list = await database.rawQuery(
        "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
        "WHERE "
        "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_READ_STATUS} = ? ",
        [ReadStatus.UNREAD.index]);
    return list == null ? 0 : list.length;
  }

  Future<List<CustomMessage>> getCustomMessageList(String conversationId, int beginId) async {
    SLog.i("getCustomMessageList conversationId: $conversationId");
    List<Map<String, dynamic>> mapList;
    if (beginId > 0) {
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
          "WHERE "
          "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
          "AND ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} < ? "
          "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  ASC",
          [conversationId, beginId]);
    } else {
      mapList = await database.rawQuery(
          "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE} "
          "WHERE "
          "${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID} = ? "
          "ORDER BY ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID}  ASC",
          [conversationId]);
    }
    SLog.i("getCustomMessageList mapList: ${mapList.length}");
    return mapList.map((e) => _convertCustomMessage(e)).toList();
  }

  Future<CustomMessage> getCustomMessageByMessageId(int messageId) async {
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT * FROM ${SnowIMDBHelper.TABLE_MESSAGE}"
        " WHERE ${SnowIMDBHelper.TABLE_MESSAGE_COLUMN_MESSAGE_ID} = ?",
        [messageId]);
    if (maps == null || maps.isEmpty) {
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
    readyMessage.conversationId = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONVERSATION_ID];
    String content = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_CONTENT];
    readyMessage.content = content;
    readyMessage.decode(content);
    readyMessage.direction = _getDirection(readyMessage.uid);
    readyMessage.time = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_TIME];
    int status = map[SnowIMDBHelper.TABLE_MESSAGE_COLUMN_STATUS];
    readyMessage.status = SendStatus.values.where((element) => element.index == status).first;
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
