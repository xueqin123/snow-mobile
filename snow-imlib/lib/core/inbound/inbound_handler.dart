import 'package:imlib/proto/message.pb.dart';

import '../snow_im_context.dart';

abstract class InboundHandler {
  bool onRead(SnowIMContext context, SnowMessage snowMessage);
}
