import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
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

  StreamController<List<MessageWrapper>> getMessageController(String targetId, ConversationType conversationType) {
    messageNotifier = MessageNotifier(targetId);
    SnowIMLib.getHistoryMessage(targetId, conversationType, 0, 20).then((value) => {messageNotifier.onHistory(value)});
    return messageNotifier.streamController;
  }

  sendTextMessage(String targetId, String text, ConversationType conversationType) {
    TextMessage textMessage = TextMessage(text: text);
    if (conversationType == ConversationType.SINGLE) {
      SnowIMLib.sendSingleMessage(targetId, textMessage, block: _messageSendBlock);
    } else if (conversationType == ConversationType.GROUP) {
      SnowIMLib.sendGroupMessage(targetId, textMessage, block: _messageSendBlock);
    }
  }

  _messageSendBlock(SendStatus status, CustomMessage customMessage) {
    if (messageNotifier != null) {
      messageNotifier.onSend(status, customMessage);
    }
  }
}

class MessageNotifier extends Notifier<List<MessageWrapper>> {
  String targetId;
  List<MessageWrapper> data = List();

  onSend(SendStatus status, CustomMessage customMessage) async {
    SLog.i("MessageNotifier onSend() $status customMessage.cid: ${customMessage.cid}");
    if (status == SendStatus.SENDING) {
      MessageWrapper messageWrapper = await MessageWrapper.create(customMessage);
      data.add(messageWrapper);
    } else {
      for (MessageWrapper element in data) {
        SLog.i("MessageNotifier targetCid ${element.customMessage.cid} customCid:${customMessage.cid}}");
        CustomMessage old = element.customMessage;
        if (customMessage.cid != null && customMessage.cid == old.cid) {
          old.id = customMessage.id;
          old.status = customMessage.status;
          old.time = customMessage.time;
          old.targetId = customMessage.targetId;
          old.conversationId = customMessage.conversationId;
          break;
        }
      }
    }
    post();
  }

  onReceive(CustomMessage customMessage) async {
    SLog.i("MessageNotifier onReceive() $customMessage");
    MessageWrapper messageWrapper = await MessageWrapper.create(customMessage);
    data.add(messageWrapper);
    post();
  }

  onHistory(List<CustomMessage> historyList) async {
    SLog.i("MessageNotifier onHistory() ${historyList.length}");
    List<MessageWrapper> wrapperList = List();
    for (CustomMessage customMessage in historyList) {
      MessageWrapper messageWrapper = await MessageWrapper.create(customMessage);
      wrapperList.add(messageWrapper);
    }
    data.addAll(wrapperList);
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
    List<MessageWrapper> d = List();
    d.addAll(data);
    d.sort((a, b) => b.customMessage.time - a.customMessage.time);
    List<int> messageIds = d.map((e) => e.customMessage.id).toList();
    SnowIMLib.updateMessageReadStatus(messageIds);
    streamController.sink.add(d);
  }
}

class MessageWrapper {
  UserEntity userEntity;
  CustomMessage customMessage;

  MessageWrapper(this.userEntity, this.customMessage);

  static Future<MessageWrapper> create(customMessage) async {
    ContactModel contactModel = ModelManager.getInstance().getModel<ContactModel>();
    UserEntity userEntity = await contactModel.getUserById(customMessage.uid);
    return MessageWrapper(userEntity, customMessage);
  }
}
