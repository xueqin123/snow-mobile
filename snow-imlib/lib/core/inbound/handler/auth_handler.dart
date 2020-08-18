import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';

import '../../snow_im_context.dart';


class AuthHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage message) {
    if (message.type == SnowMessage_Type.LoginAck) {
      LoginAck loginAck = message.loginAck;
      SLog.i(" loginAck id:${loginAck.id} code:${loginAck.code} msg:${loginAck.msg} time:${loginAck.time}");
      if (loginAck.code == Code.SUCCESS) {
        context.onLoginSuccess();
      } else {
        context.onLoginFailed(loginAck.code, loginAck.msg);
      }
      return true;
    }
    return false;
  }
}
