import 'dart:async';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_group_model.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

class SnowDataFetchHelper {
  static SnowDataFetchHelper _instance;
  Map<Int64, Completer<List<MessageContent>>> waitAckHisMsgMap = Map();
  Map<Int64, Completer<List<ConversationInfo>>> waitAckHisConvMap = Map();

  SnowIMContext context;
  SnowIMMessageModel snowMessageModel;
  SnowIMConversationModel conversationModel;
  SnowIMGroupModel groupModel;

  SnowDataFetchHelper._();

  static SnowDataFetchHelper getInstance() {
    if (_instance == null) {
      _instance = SnowDataFetchHelper._();
    }
    return _instance;
  }

  init(SnowIMContext context) {
    this.context = context;
    snowMessageModel = SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>();
    conversationModel = SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>();
    groupModel = SnowIMModelManager.getInstance().getModel<SnowIMGroupModel>();
  }

  Future<List<ConversationInfo>> fetchConversationList() {
    Int64 cid = SnowIMUtils.generateCid();
    ConversationReq conversationReq = ConversationReq();
    conversationReq.type = OperationType.ALL;
    conversationReq.id = cid;
    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.ConversationReq;
    snowMessage.conversationReq = conversationReq;
    context.sendSnowMessage(snowMessage);
    Completer completer = Completer<List<ConversationInfo>>();
    waitAckHisConvMap[cid] = completer;
    return completer.future;
  }

  Future<List<MessageContent>> _fetchHistoryMessageList(String conversationId, int beginId) {
    Completer completer = Completer<List<MessageContent>>();
    Int64 cid = SnowIMUtils.generateCid();
    HisMessagesReq hisMessagesReq = HisMessagesReq();
    hisMessagesReq.id = cid;
    hisMessagesReq.beginId = Int64(beginId);
    hisMessagesReq.conversationId = conversationId;
    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.HisMessagesReq;
    snowMessage.hisMessagesReq = hisMessagesReq;
    waitAckHisMsgMap[cid] = completer;
    context.sendSnowMessage(snowMessage);
    return completer.future;
  }

  onConversationListAck(Int64 cid, List<ConversationInfo> conversationList) async {
    SLog.i("SnowDataFetchHelper onConversationListAck() conversation size: ${conversationList.length}");
    waitAckHisConvMap[cid].complete(conversationList);
    waitAckHisConvMap.remove(cid);
    await conversationModel.saveConversationList(conversationList);
    await _fetchAllGroup(conversationList);
    await _fetchAllMessage(conversationList);
    SLog.i("SnowDataFetchHelper onConversationListAck() rest length: ${waitAckHisConvMap.length}");
  }

  _fetchAllMessage(List<ConversationInfo> conversationList) async {
    for (ConversationInfo conversationInfo in conversationList) {
      await _fetchHistoryMessageList(conversationInfo.conversationId, 0);
    }
  }

  _fetchAllGroup(List<ConversationInfo> conversationList) async {
    for (ConversationInfo conversationInfo in conversationList) {
      if (conversationInfo.type == ConversationType.GROUP) {
        await groupModel.syncGroupByGroupId(conversationInfo.groupId);
      }
    }
  }

  onHistoryMessageAck(Int64 cid, String conversationId, List<MessageContent> messageContentList, int unReadCount) {
    SLog.i("SnowDataFetchHelper messageContentList:${messageContentList.length} ");
    waitAckHisMsgMap[cid].complete(messageContentList);
    waitAckHisMsgMap.remove(cid);
    snowMessageModel.saveSnowMessageList(conversationId, messageContentList, unReadCount);
    SLog.i("SnowDataFetchHelper onHistoryMessageAck() reset length: ${waitAckHisMsgMap.length}");
  }
}
