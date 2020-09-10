import 'package:imlib/core/snow_im_context.dart';

import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';

import '../inbound_handler.dart';

class NotifyHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.NotifyMessage) {
      NotifyMessage notifyMessage = snowMessage.notifyMessage;
      SLog.i("NotifyHandler fromUid:${notifyMessage.fromUid} content:${notifyMessage.content}");
      return true;
    } else {
      return false;
    }
  }
}
