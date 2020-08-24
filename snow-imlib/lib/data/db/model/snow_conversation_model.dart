import 'dart:async';
import 'dart:collection';

import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/dao/snow_im_message_dao.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/data/db/model/snow_message_model.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/snow_im_utils.dart';
import 'package:fixnum/fixnum.dart';

import '../../../imlib.dart';

class SnowConversationModel extends SnowIMModel {
  // ignore: close_sinks
  StreamController<List<Conversation>> _conversationListController;

  SnowConversationModel() {
    _conversationListController = StreamController();
  }

  StreamController<List<Conversation>> getConversationController() {
    return _conversationListController;
  }

  saveConversationList(List<ConversationInfo> conversationInfList) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    await dao.saveConversationList(conversationInfList);
    _notifyConversationChange();
  }

  saveConversation(ConversationInfo conversationInfo) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    await dao.saveConversationList(<ConversationInfo>[conversationInfo]);
    _notifyConversationChange();
  }


  insertOrUpdateConversationBySend(String conversationId,ConversationType conversationType, CustomMessage customMessage){
    MessageContent messageContent = MessageContent();
    messageContent.content = customMessage.content;
    messageContent.uid = customMessage.uid;
    messageContent.type = customMessage.type;
    messageContent.time = Int64(customMessage.time);
    messageContent.id = Int64(customMessage.id);
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.id = Int64(customMessage.id);
    upDownMessage.content= messageContent;
    upDownMessage.conversationId = conversationId;
    upDownMessage.targetUid = customMessage.targetId;
    upDownMessage.conversationType = conversationType;
    upDownMessage.fromUid = customMessage.uid;
    upDownMessage.cid = Int64(customMessage.cid);
    insertOrUpdateConversationByUpDown(upDownMessage);
  }


  insertOrUpdateConversationByUpDown(UpDownMessage upDownMessage) async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    ConversationInfo conversationInfo = ConversationInfo();
    conversationInfo.conversationId = upDownMessage.conversationId;
    conversationInfo.lastContent = upDownMessage.content;
    conversationInfo.time = Int64(SnowIMUtils.currentTime());
    conversationInfo.type = upDownMessage.conversationType;
    conversationInfo.groupId = upDownMessage.groupId;
    conversationInfo.uidList.add(upDownMessage.fromUid);
    conversationInfo.uidList.add(upDownMessage.targetUid);
    conversationInfo.readMsgId = Int64(0);
    await dao.saveConversationList(<ConversationInfo>[conversationInfo]);
    _notifyConversationChange();
  }

  _notifyConversationChange() async {
    SnowIMConversationDao dao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    SnowIMMessageDao messageDao = SnowIMDaoManager.getInstance().getDao<SnowIMMessageDao>();
    List<Conversation> result = await dao.getConversationAllList();
    SLog.i("_notifyConversationChange :${result.length}");
    for (Conversation conversation in result) {
      conversation.unReadCount = await messageDao.getUnReadMessageCount(conversation.conversationId);
    }
    _conversationListController.sink.add(result);
  }

  onUnReadCountChanged() async {
    _notifyConversationChange();
  }
}
