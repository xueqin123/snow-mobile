import 'dart:async';

import 'package:imlib/data/db/dao/snow_im_conversation_dao.dart';
import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/dao/snow_im_message_dao.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/snow_im_utils.dart';
import 'package:fixnum/fixnum.dart';

import '../../../imlib.dart';

class SnowIMConversationModel extends SnowIMModel {
  // ignore: close_sinks
  StreamController<List<Conversation>> _conversationListController;
  // ignore: close_sinks
  StreamController<int> _totalUnReadCountController;
  SnowIMConversationDao conversationDao;

  SnowIMConversationModel() {
    conversationDao = SnowIMDaoManager.getInstance().getDao<SnowIMConversationDao>();
    _conversationListController = StreamController();
    _totalUnReadCountController = StreamController();
  }

  StreamController<List<Conversation>> getConversationController() {
    return _conversationListController;
  }

  StreamController<int> getTotalUnReadController(){
    return _totalUnReadCountController;
  }

  saveConversationList(List<ConversationInfo> conversationInfList) async {
    await conversationDao.saveConversationList(conversationInfList);
    _notifyConversationChange();
  }

  saveConversation(ConversationInfo conversationInfo) async {
    await conversationDao.saveConversationList(<ConversationInfo>[conversationInfo]);
    _notifyConversationChange();
  }

  Future<Conversation> getConversationByConversationId(String conversationId) async {
    return conversationDao.getConversationByConversationId(conversationId);
  }

  Future<Conversation> getSingleConversationByTarget(String targetId) async {
    return conversationDao.getSingleConversationByTarget(targetId);
  }

  insertOrUpdateConversationBySend(String conversationId, ConversationType conversationType, CustomMessage customMessage) {
    MessageContent messageContent = MessageContent();
    messageContent.content = customMessage.content;
    messageContent.uid = customMessage.uid;
    messageContent.type = customMessage.type;
    messageContent.time = Int64(customMessage.time);
    messageContent.id = Int64(customMessage.id);
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.id = Int64(customMessage.id);
    upDownMessage.content = messageContent;
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
    SnowIMMessageDao messageDao = SnowIMDaoManager.getInstance().getDao<SnowIMMessageDao>();
    List<Conversation> result = await conversationDao.getConversationAllList();
    SLog.i("_notifyConversationChange :${result.length}");
    for (Conversation conversation in result) {
      conversation.unReadCount = await messageDao.getUnReadMessageCount(conversation.conversationId);
    }
    int totalUnReadCount = await messageDao.getTotalUnReadMessageCount();
    SLog.i("_notifyConversationChange totalUnReadCount:$totalUnReadCount");
    _conversationListController.sink.add(result);
    _totalUnReadCountController.sink.add(totalUnReadCount);
  }

  onUnReadCountChanged() async {
    _notifyConversationChange();
  }
}
