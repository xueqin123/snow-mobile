import 'dart:typed_data';

import 'package:imlib/proto/message.pb.dart';

class SnowMessageDecoder {
  SnowMessage decode(Uint8List uint8list) {
    SnowMessage snowMessage = SnowMessage.fromBuffer(uint8list);
    return snowMessage;
  }
}
