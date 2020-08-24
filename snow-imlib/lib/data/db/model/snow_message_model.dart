import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/dao/snow_im_message_dao.dart';
import 'package:imlib/data/db/entity/conversation_entity.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';

class SnowMessageModel extends SnowIMModel {
  SnowIMMessageDao messageDao;
  SnowIMConversationDao conversationDao;
  Map<String, String> targetMap = Map();

  SnowMessageModel() {
    messageDao = SnowIMDaoManager.getInstance().getDao<SnowIMMessageDao>();
    conversationDao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    SLog.i("conversationDao :$conversationDao");
  }

  saveReceivedMessageContent(String conversationId, MessageContent messageContent) async {
    await messageDao.saveReceiveSnowMessage(conversationId, messageContent);
    CustomMessage customMessage = await messageDao.getCustomMessageByMessageId(messageContent.id.toInt());
    Conversation conversation = await conversationDao.getConversationByConversationId(customMessage.targetId);
    if (conversation.type == ConversationType.SINGLE) {
      customMessage.targetId = conversation.uidList.where((element) => element != SnowIMContext.getInstance().selfUid).first;
    }
    SnowIMContext.getInstance().getCustomMessageController().sink.add(customMessage);
  }

  saveSnowMessageList(String conversationId, List<MessageContent> messageContentList) async {
    await messageDao.saveSnowMessageList(conversationId, messageContentList);
  }

  updateMessageReadStatus(List<int> messageIdList) async {
    await messageDao.updateMessageReadStatus(messageIdList);
  }

  Future<List<CustomMessage>> getSnowMessageList(String targetId, ConversationType conversationType, int beginId, int count) async {
    String conversationId = targetId;
    if (conversationType == ConversationType.SINGLE) {
      String temp = targetMap[targetId];
      if (temp != null) {
        conversationId = temp;
      } else {
        Conversation conversation = await conversationDao.getSingleConversationTarget(targetId);
        if (conversation == null) {
          return List();
        }
        conversationId = conversation.conversationId;
        targetMap[targetId] = conversationId;
      }
    }
    return await messageDao.getCustomMessageList(conversationId, beginId);
  }

  Future insertSendMessage(String conversationId, CustomMessage customMessage) async {
    await messageDao.insertSendMessage(conversationId, customMessage);
  }

  Future<CustomMessage> updateSendMessage(int messageId, String conversationId, SendStatus status, int cid) async {
    await messageDao.updateSendMessage(messageId, conversationId, status, cid);
    CustomMessage customMessage = await getCustomMessageById(messageId);
    return customMessage;
  }

  Future<CustomMessage> getCustomMessageById(int messageId) {
    return messageDao.getCustomMessageByMessageId(messageId);
  }
}
