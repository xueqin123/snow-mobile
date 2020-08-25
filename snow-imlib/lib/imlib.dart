library imlib;

export 'package:imlib/imlib.dart';
export 'package:imlib/utils/s_log.dart';
export 'package:imlib/data/db/entity/conversation_entity.dart';
import 'dart:async';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/entity/conversation_entity.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/message/message_manager.dart';
import 'package:imlib/proto/message.pb.dart';

typedef SendBlock = Function(SendStatus status, CustomMessage customMessage);
typedef MessageProvider = CustomMessage Function();

class SnowIMLib {
  static init(String uid) async {
    await SnowIMContext.getInstance().init(uid);
  }

  static connect(String token) async {
    return SnowIMContext.getInstance().connect(token);
  }

  static disConnect() {
    SnowIMContext.getInstance().disConnect();
  }

  static getConnectStatusStream() {
    return SnowIMContext.getInstance().getConnectStatusController().stream;
  }

  static Stream<CustomMessage> getCustomMessageStream() {
    return SnowIMContext.getInstance().getCustomMessageController().stream;
  }

  static Future<List<CustomMessage>> getHistoryMessage(String targetId, ConversationType conversationType, int beginId, int count) {
    return SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().getSnowMessageList(targetId, conversationType, beginId, count);
  }

  static updateMessageReadStatus(List<int> messageIds) {
    return SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().updateMessageReadStatus(messageIds);
  }

  static Stream<List<Conversation>> getConversationStream() {
    return SnowIMContext.getInstance().getConversationListController().stream;
  }

  static Stream<int> getTotalUnReadCountStream() {
    return SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().getTotalUnReadController().stream;
  }

  static sendSingleMessage(String targetId, CustomMessage customMessage, {SendBlock block}) {
    customMessage.conversationType = ConversationType.SINGLE;
    customMessage.type = customMessage.runtimeType.toString();
    customMessage.targetId = targetId;
    return SnowIMContext.getInstance().sendCustomMessage(customMessage, block);
  }

  static sendGroupMessage(String conversationId, CustomMessage customMessage, {SendBlock block}) {
    customMessage.conversationType = ConversationType.GROUP;
    customMessage.type = customMessage.runtimeType.toString();
    customMessage.targetId = conversationId;
  }

  static registerMessage(Type messageType, MessageProvider emptyProvider) {
    MessageManager.getInstance().registerMessageProvider(messageType, emptyProvider);
  }

  static String getCurrentUid() {
    return SnowIMContext.getInstance().selfUid;
  }
}

enum SendStatus { SENDING, PERSIST, SUCCESS, FAILED }
enum ReadStatus { READ, UNREAD }
