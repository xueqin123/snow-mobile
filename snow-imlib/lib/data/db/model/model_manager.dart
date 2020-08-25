import 'package:flutter/material.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';

class SnowIMModelManager {
  static SnowIMModelManager _instance;
  Map<String, SnowIMModel> _models = Map<String, SnowIMModel>();

  SnowIMModelManager._();

  static SnowIMModelManager getInstance() {
    if (_instance == null) {
      _instance = SnowIMModelManager._();
      SnowIMConversationModel conversationModel = SnowIMConversationModel();
      _instance.register(conversationModel);
      SnowIMMessageModel messageModel = SnowIMMessageModel();
      _instance.register(messageModel);
    }
    return _instance;
  }

  void register(SnowIMModel model) {
    _models[model.runtimeType.toString()] = model;
  }

  T getModel<T>() {
    return _models[T.toString()] as T;
  }
}
