import 'package:flutter/cupertino.dart';
import 'package:imlib/message/custom_message.dart';

typedef MessageWidgetProvider = Widget Function(CustomMessage customMessage);
typedef ConversationContentProvider = String Function(String lastContent);

class MessageWidgetManager {
  static MessageWidgetManager _instance;

  MessageWidgetManager._();

  static MessageWidgetManager getInstance() {
    if (_instance == null) {
      _instance = MessageWidgetManager._();
    }
    return _instance;
  }

  Map<String, MessageWidgetProvider> _messageWidgetMap = Map();
  Map<String, ConversationContentProvider> _conversationContentMap = Map();

  registerMessageWidgetProvider(Type messageType, MessageWidgetProvider provider) {
    _messageWidgetMap[messageType.toString()] = provider;
  }
  registerConversationContentProvider(Type messageType, ConversationContentProvider provider) {
    _conversationContentMap[messageType.toString()] = provider;
  }

  getConversationContentProvider(String type){
    return _conversationContentMap[type];
  }

  getMessageWidgetProvider(String type) {
    return _messageWidgetMap[type];
  }
}

