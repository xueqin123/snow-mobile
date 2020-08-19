import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/conversation_model.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';

class ConversationAckHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.ConversationAck) {
      ConversationInfo conversationInfo = snowMessage.conversationAck.conversationInfo;
      List<ConversationInfo> conversationInfoList = snowMessage.conversationAck.conversationList;
      SLog.i("conversation list size:${conversationInfoList.length}");
      ConversationModel conversationModel = SnowIMModelManager.getInstance().getModel<ConversationModel>();
      if (conversationInfoList != null) {
        conversationModel.saveConversationList(conversationInfoList);
      }
      return true;
    } else {
      return false;
    }
  }
}
