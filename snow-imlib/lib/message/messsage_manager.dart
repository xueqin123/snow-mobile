import '../imlib.dart';

class MessageManager {
  static MessageManager _instance;

  MessageManager._();

  static MessageManager getInstance() {
    if (_instance == null) {
      _instance = MessageManager._();
    }
    return _instance;
  }

  Map<String, MessageProvider> _messageMap = Map();

  registerMessageProvider(String messageType, MessageProvider messageProvider) {
    _messageMap[messageType] = messageProvider;
  }

  getMessageProvider(String type) {
    return _messageMap[type];
  }
}
