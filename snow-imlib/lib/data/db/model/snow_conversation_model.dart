import 'dart:async';

import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/proto/message.pb.dart';

import '../../../imlib.dart';

class SnowConversationModel extends SnowIMModel {
  // ignore: close_sinks
  StreamController<List<Conversation>> _conversationListController = StreamController();

  StreamController<List<Conversation>> getConversationController() {
    return _conversationListController;
  }

  saveConversationList(List<ConversationInfo> conversationInfList) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    await dao.saveConversationList(conversationInfList);
    List<Conversation> result = await dao.getConversationAllList();
    _conversationListController.sink.add(result);
  }

  saveConversation(ConversationInfo conversationInfo) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    await dao.saveConversationList(<ConversationInfo>[conversationInfo]);
    List<Conversation> result = await dao.getConversationAllList();
    _conversationListController.sink.add(result);
  }
}