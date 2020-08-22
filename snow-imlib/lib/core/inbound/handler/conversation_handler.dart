import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/snow_fetch_helper.dart';

class ConversationHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.ConversationAck) {
      ConversationAck conversationAck = snowMessage.conversationAck;
      List<ConversationInfo> conversationInfoList = snowMessage.conversationAck.conversationList;
      SnowAckHelper.getInstance().onConversationListAck(conversationAck.id, conversationInfoList);
      return true;
    } else {
      return false;
    }
  }
}
