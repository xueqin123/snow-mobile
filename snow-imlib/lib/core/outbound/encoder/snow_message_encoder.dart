import 'dart:typed_data';

import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';

class SnowMessageEncoder extends OutboundEncoder<SnowMessage> {
  @override
  encodeSend(SnowIMContext context, SnowMessage data) {
    SLog.v("SnowMessageEncoder encode start!");
    Uint8List sendBody = data.writeToBuffer();
    SLog.v("SnowMessageEncoder encode end!");
    if (next != null) {
      next.encodeSend(context, sendBody);
    }
  }
}
