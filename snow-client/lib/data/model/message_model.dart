import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/messages/text_message.dart';

import 'base_model.dart';
import 'notifier.dart';

class MessageModel extends BaseModel {
  MessageNotifier messageNotifier;
  List<CustomMessage> missedMessage = List<CustomMessage>();

  MessageModel() {
    SnowIMLib.getCustomMessageStream().listen((event) {
      if (messageNotifier != null && event.targetId == messageNotifier.targetId) {
        messageNotifier.onReceive(event);
      }
    });
  }

  StreamController<List<CustomMessage>> getMessageController(String targetId, ConversationType conversationType) {
    messageNotifier = MessageNotifier(targetId);
    SnowIMLib.getHistoryMessage(targetId, conversationType, 0, 20).then((value) => {messageNotifier.onHistory(value)});
    return messageNotifier.streamController;
  }

  _onCancel() {
    SLog.i("MessageModel _onCancel()");
  }

  sendTextMessage(String targetId, String text) {
    TextMessage textMessage = TextMessage(text: text);
    SnowIMLib.sendSingleMessage(targetId, textMessage, block: (status, customMessage) {
      messageNotifier.onSend(status, customMessage);
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
    if (streamController.isClosed) {
      SLog.i("MessageNotifier post() streamController.isClosed: ${streamController.isClosed}");
      return;
    }
    List<CustomMessage> d = List();
    d.addAll(data);
    d.sort((a, b) => b.time - a.time);
    List<int> messageIds = d.map((e) => e.id).toList();
    SnowIMLib.updateMessageReadStatus(messageIds);
    streamController.sink.add(d);
  }
}
