import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/proto/message.pb.dart';

class HistoryMessageHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage message) {
    if (message.type == SnowMessage_Type.MessageAck) {
      return true;
    }
    return false;
  }
}
