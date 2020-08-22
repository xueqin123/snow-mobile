import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/message_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class MessageViewModel with ChangeNotifier {
  TextEditingController _sendTextController = TextEditingController();

  get sendTextController => _sendTextController;
  List<CustomMessage> data;
  String targetId;
  ConversationType chatType;
  String chatName = "";
  ContactModel contactModel;
  MessageModel messageModel;

  MessageViewModel(this.targetId, this.chatType) {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    messageModel = ModelManager.getInstance().getModel<MessageModel>();
  }

  StreamController<UserEntity> getUserController() {
    return contactModel.getUserController(targetId);
  }

  StreamController<List<CustomMessage>> getMessageController(String targetId, ConversationType conversationType) {
    StreamController controller = messageModel.getMessageController(targetId, conversationType);
    return controller;
  }

  sendTextMessage() {
    messageModel.sendTextMessage(targetId, _sendTextController.text);
  }
}
