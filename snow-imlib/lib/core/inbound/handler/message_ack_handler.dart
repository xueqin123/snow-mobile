import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/proto/message.pb.dart';

class MessageAckHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.MessageAck) {
      MessageAck messageAck = snowMessage.messageAck;
      context.onMessageAck(messageAck.cid, messageAck.code);
      return true;
    }
    return false;
  }
}
