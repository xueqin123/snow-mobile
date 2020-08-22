import 'dart:async';

import 'package:flutter/material.dart';
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

  saveMessageContent(String conversationId, MessageContent messageContent) {
    messageDao.saveSnowMessage(conversationId, messageContent);
  }

  saveSnowMessageList(String conversationId, List<MessageContent> messageContentList) {
    messageDao.saveSnowMessageList(conversationId, messageContentList);
  }


  Future<List<CustomMessage>> getSnowMessageList(String targetId, ConversationType conversationType, int beginId, int count) async {
    String conversationId = targetId;
    if (conversationType == ConversationType.SINGLE) {
      String temp = targetMap[targetId];
      if (temp != null) {
        conversationId = temp;
      } else {
        Conversation conversation = await conversationDao.getConversation(targetId);
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

  updateSendMessage(int messageId, SendStatus status, int cid) {
    messageDao.updateSendMessage(messageId, status, cid);
  }

  Future<CustomMessage> getCustomMessageById(int messageId){
   return messageDao.getCustomMessageByMessageId(messageId);
  }
}
