import 'dart:async';

import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/proto/message.pb.dart';

import '../../../imlib.dart';

class ConversationModel extends SnowIMModel {
  // ignore: close_sinks
  StreamController<List<ConversationEntity>> _conversationListController = StreamController();

  StreamController<List<ConversationEntity>> getConversationController() {
    return _conversationListController;
  }

  saveConversationList(List<ConversationInfo> conversationInfList) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    await dao.saveConversationList(conversationInfList);
    List<ConversationEntity> result = await dao.getConversationAllList();
    SLog.i("add conversationList length:${result.length}");
    _conversationListController.sink.add(result);
  }

  saveConversation(ConversationInfo conversationInfo) {
    //todo
  }
}
