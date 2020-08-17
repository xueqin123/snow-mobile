import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/snow_im_context.dart';

class AuthHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage message) {
    if (message.type == SnowMessage_Type.LoginAck) {
      LoginAck loginAck = message.loginAck;
      print(" loginAck id:${loginAck.id} code:${loginAck.code} msg:${loginAck.msg} time:${loginAck.time}");
      if (loginAck.code == Code.SUCCESS) {
        context.loginSuccess();
      } else {
        context.loginFailed(loginAck.code, loginAck.msg);
      }
      return true;
    }
    return false;
  }
}
