import 'package:imlib/proto/message.pb.dart';

import '../snow_im_context.dart';
import 'inbound_handler.dart';

class InboundChain {
  InboundChain next;
  InboundHandler _inboundHandler;

  void handle(SnowIMContext context, SnowMessage snowMessage) {
    if (!_inboundHandler.onRead(context, snowMessage) && next != null) {
      next.handle(context, snowMessage);
    }
  }

  InboundChain(this._inboundHandler);
}
