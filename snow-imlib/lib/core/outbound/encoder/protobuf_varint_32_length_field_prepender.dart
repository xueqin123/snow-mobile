import 'dart:typed_data';

import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/utils/s_log.dart';

class ProtobufVarint32LengthFieldPrepender extends OutboundEncoder<Uint8List> {
  @override
  encodeSend(SnowIMContext context, Uint8List data) {
    SLog.v("ProtobufVarint32LengthFieldPrepender start!");
    int messageLength = data.length;
    int headLength = _computerRawVarint32Size(messageLength);
    Uint8List head = Uint8List(headLength);
    _writeRawVarint32(head, messageLength);
    Uint8List total = Uint8List(head.length + messageLength);
    List.copyRange(total, 0, head);
    List.copyRange(total, head.length, data);
    SLog.v("encode data headLength: ${head.length} bodyLength:$messageLength totalLength:${total.length} ");
    context.write(total); //real write to socket
    SLog.v("ProtobufVarint32LengthFieldPrepender end !");
  }

  void _writeRawVarint32(Uint8List head, int messageLength) {
    int index = 0;
    while (true) {
      if ((messageLength & ~0x7F) == 0) {
        head[index++] = messageLength;
        return;
      } else {
        head[index++] = (messageLength & 0x7F) | 0x80;
        messageLength >>= 7;
      }
    }
  }

  //计算 head 占的位数
  int _computerRawVarint32Size(int value) {
    if ((value & (0xffffffff << 7)) == 0) {
      return 1;
    }
    if ((value & (0xffffffff << 14)) == 0) {
      return 2;
    }
    if ((value & (0xffffffff << 21)) == 0) {
      return 3;
    }
    if ((value & (0xffffffff << 28)) == 0) {
      return 4;
    }
    return 5;
  }
}
