library imlib;

export 'package:imlib/imlib.dart';
export 'package:imlib/utils/s_log.dart';
export 'package:imlib/data/db/entity/conversation_entity.dart';
import 'dart:async';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/entity/conversation_entity.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/message/message_manager.dart';

typedef SendBlock = Function(SendStatus status);
typedef MessageProvider = CustomMessage Function();

class SnowIMLib {
  static connect(String token, uid) async {
    return SnowIMContext.getInstance().connect(token, uid);
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

  static StreamController<List<ConversationEntity>> getConversationController() {
    return SnowIMContext.getInstance().getConversationListController();
  }

  static sendMessage(CustomMessage customMessage, {SendBlock block}) {
    return SnowIMContext.getInstance().sendCustomMessage(customMessage, block);
  }

  static registerMessage(Type messageType, MessageProvider emptyProvider) {
    MessageManager.getInstance().registerMessageProvider(messageType, emptyProvider);
  }

  static String getCurrentUid() {
    return SnowIMContext.getInstance().selfUid;
  }
}

enum SendStatus { SENDING, SUCCESS, FAILED }
