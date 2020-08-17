import 'dart:typed_data';

import 'package:imlib/proto/message.pb.dart';

class SnowMessageEncoder {
  Uint8List encode(SnowMessage snowMessage) {
    Uint8List sendBody = snowMessage.writeToBuffer();
    return sendBody;
  }
}
