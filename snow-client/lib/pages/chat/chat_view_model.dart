import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snowclient/data/model/chat_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

import 'chat_item_entity.dart';

class ChatViewModel with ChangeNotifier {
  List<ChatItemEntity> data = List();
  ChatModel chatModel;

  ChatViewModel() {
    chatModel = ModelManager.getInstance().getModel<ChatModel>();
  }

  StreamController<List<ChatItemEntity>> getChatListController() {
    return chatModel.getChatController();
  }
}
