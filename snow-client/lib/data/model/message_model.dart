import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/messages/text_message.dart';

import 'base_model.dart';
import 'notifier.dart';

class MessageModel extends BaseModel {
  Map<String, MessageNotifier> map = Map();

  MessageModel() {
    SnowIMLib.getCustomMessageStream().listen((event) {
      MessageNotifier messageNotifier = map[event.targetId];
      if (messageNotifier != null) {
        messageNotifier.onReceive(event);
      }
    });
  }

  StreamController<List<CustomMessage>> getMessageController(String targetId, ConversationType conversationType) {
    MessageNotifier messageNotifier = MessageNotifier(targetId);
    map[targetId] = messageNotifier;
    SnowIMLib.getHistoryMessage(targetId, conversationType, 0, 20).then((value) => messageNotifier.onHistory(value));
    return messageNotifier.streamController;
  }

  sendTextMessage(String targetId, String text) {
    TextMessage textMessage = TextMessage(content: text);
    SnowIMLib.sendSingleMessage(targetId, textMessage, block: (status, customMessage) {
      map[targetId].onSend(customMessage);
    });
  }
}

class MessageNotifier extends Notifier<List<CustomMessage>> {
  String targetId;
  List<CustomMessage> data = List();

  onSend(CustomMessage customMessage) {
    SLog.i("MessageNotifier onSend() $customMessage");
    data.add(customMessage);
    post();
  }

  onReceive(CustomMessage customMessage) {
    SLog.i("MessageNotifier onReceive() $customMessage");
    data.add(customMessage);
    post();
  }

  onHistory(List<CustomMessage> historyList) {
    SLog.i("MessageNotifier onHistory() $historyList");
    data.addAll(historyList);
    post();
  }

  MessageNotifier(this.targetId);

  @override
  Future post() async {
    SLog.i("MessageNotifier post() data.length: ${data.length}");
    List<CustomMessage> d = List();
    d.addAll(data);
    streamController.sink.add(d);
  }
}
