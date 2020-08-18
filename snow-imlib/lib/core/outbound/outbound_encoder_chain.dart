import 'package:imlib/core/outbound/outbound_encoder.dart';

import '../snow_im_context.dart';

class OutboundChain {
  OutboundChain next;
  OutboundEncoder _outboundEncoder;

  encode(SnowIMContext context, dynamic data) {
    var cur = _outboundEncoder.encode(context, data);
    if (next != null) {
      return next._outboundEncoder.encode(context, cur);
    } else {
      return cur;
    }
  }

  OutboundChain(this._outboundEncoder);
}
