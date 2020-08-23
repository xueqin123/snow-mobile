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
    map.clear();
    MessageNotifier messageNotifier = MessageNotifier(targetId);
    map[targetId] = messageNotifier;
    SnowIMLib.getHistoryMessage(targetId, conversationType, 0, 20).then((value) => messageNotifier.onHistory(value));
    return messageNotifier.streamController;
  }

  sendTextMessage(String targetId, String text) {
    TextMessage textMessage = TextMessage(content: text);
    SnowIMLib.sendSingleMessage(targetId, textMessage, block: (status, customMessage) {
      map[targetId].onSend(status, customMessage);
    });
  }
}

class MessageNotifier extends Notifier<List<CustomMessage>> {
  String targetId;
  List<CustomMessage> data = List();

  onSend(SendStatus status, CustomMessage customMessage) {
    SLog.i("MessageNotifier onSend() $status");
    if (status == SendStatus.SENDING) {
      data.add(customMessage);
    } else {
      SLog.i("MessageNotifier onSend()  :${customMessage.id}");
      for (CustomMessage element in data) {
        if (customMessage.cid == element.cid) {
          element.id = customMessage.id;
          element.status = customMessage.status;
          element.time = customMessage.time;
          element.targetId = customMessage.targetId;
        }
        break;
      }
    }
    post();
  }

  onReceive(CustomMessage customMessage) {
    SLog.i("MessageNotifier onReceive() $customMessage");
    data.add(customMessage);
    post();
  }

  onHistory(List<CustomMessage> historyList) {
    SLog.i("MessageNotifier onHistory() ${historyList.length}");
    data.addAll(historyList);
    post();
  }

  MessageNotifier(this.targetId);

  @override
  Future post() async {
    SLog.i("MessageNotifier post() data.length: ${data.length}");
    List<CustomMessage> d = List();
    d.addAll(data);
    d.sort((a, b) => b.time - a.time);
    d.forEach((element) {
      SLog.i("element.time:${element.time}");
    });
    streamController.sink.add(d);
  }
}
