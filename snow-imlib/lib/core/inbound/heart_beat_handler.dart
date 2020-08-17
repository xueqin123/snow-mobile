import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';

class HeardBeatHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage message) {
    if (message.type == SnowMessage_Type.HeartBeat) {
      HeartBeat heartBeat = message.heartBeat;
      if (heartBeat.heartBeatType == HeartBeatType.PING) {
        context.write(_buildPong(message));
      }
      return true;
    }
    return false;
  }

  SnowMessage _buildPong(SnowMessage message) {
    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.HeartBeat;
    HeartBeat heartBeat = HeartBeat();
    heartBeat.id = message.heartBeat.id;
    heartBeat.heartBeatType = HeartBeatType.PONG;
    snowMessage.heartBeat = heartBeat;
    return snowMessage;
  }
}
