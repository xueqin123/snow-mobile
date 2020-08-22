import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/rest/snow_fetch_helper.dart';

class HistoryMessageHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.HisMessagesAck) {
      HisMessagesAck hisMessagesAck = snowMessage.hisMessagesAck;
      SnowAckHelper.getInstance().onHistoryMessageAck(hisMessagesAck.id, hisMessagesAck.conversationId, hisMessagesAck.messageList);
      return true;
    }
    return false;
  }
}
