import 'dart:typed_data';

class ProtobufVarint32LengthFieldPrepender {
  Uint8List encode(Uint8List messageData) {
    int messageLength = messageData.length;
    int headLength = _computerRawVarint32Size(messageLength); //为缓存池做准备
    Uint8List head = Uint8List(headLength);
    _writeRawVarint32(head, messageLength);
    Uint8List total = Uint8List(head.length + messageLength);
    List.copyRange(total, 0, head);
    List.copyRange(total, head.length, messageData);
    print("ProtobufVarint32LengthFieldPrepender encode headLength:$headLength messageLength:$messageLength  totallength:${total.length}");
    return total;
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
