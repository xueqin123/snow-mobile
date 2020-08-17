import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';

abstract class InboundHandler {
  bool onRead(SnowIMContext context, SnowMessage message);
}
