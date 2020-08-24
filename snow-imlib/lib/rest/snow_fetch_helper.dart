import 'dart:async';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_conversation_model.dart';
import 'package:imlib/data/db/model/snow_message_model.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

class SnowDataAckHelper {
  static SnowDataAckHelper _instance;
  Map<Int64, Completer<List<MessageContent>>> waitAckHisMsgMap = Map();
  Map<Int64, Completer<List<ConversationInfo>>> waitAckHisConvMap = Map();

  SnowIMContext context;
  SnowMessageModel snowMessageModel;
  SnowConversationModel conversationModel;

  SnowDataAckHelper._();

  static SnowDataAckHelper getInstance() {
    if (_instance == null) {
      _instance = SnowDataAckHelper._();
    }
    return _instance;
  }

  init(SnowIMContext context) {
    this.context = context;
    snowMessageModel = SnowIMModelManager.getInstance().getModel<SnowMessageModel>();
    conversationModel = SnowIMModelManager.getInstance().getModel<SnowConversationModel>();
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

  onConversationListAck(Int64 cid, List<ConversationInfo> conversationList) {
    waitAckHisConvMap[cid].complete(conversationList);
    waitAckHisConvMap.remove(cid);
    conversationModel.saveConversationList(conversationList);
    _fetchAllMessage(conversationList);
    SLog.i("SnowSocketDataHelper onConversationListAck() rest length: ${waitAckHisConvMap.length}");
  }

  _fetchAllMessage(List<ConversationInfo> conversationList) async {
    for (ConversationInfo conversationInfo in conversationList) {
      _fetchHistoryMessageList(conversationInfo.conversationId, 0);
    }
  }

  onHistoryMessageAck(Int64 cid, String conversationId, List<MessageContent> messageContentList) {
    waitAckHisMsgMap[cid].complete(messageContentList);
    waitAckHisMsgMap.remove(cid);
    snowMessageModel.saveSnowMessageList(conversationId, messageContentList);
    SLog.i("SnowSocketDataHelper onHistoryMessageAck() reset length: ${waitAckHisMsgMap.length}");
  }
}
