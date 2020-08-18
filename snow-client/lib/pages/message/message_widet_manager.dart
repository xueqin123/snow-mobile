import 'package:flutter/cupertino.dart';
import 'package:imlib/message/custom_message.dart';

typedef MessageWidgetProvider = Widget Function(CustomMessage customMessage);

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

  registerMessageWidgetProvider(Type messageType, MessageWidgetProvider provider) {
    _messageWidgetMap[messageType.toString()] = provider;
  }

  getMessageWidgetProvider(String type) {
    return _messageWidgetMap[type];
  }
}

