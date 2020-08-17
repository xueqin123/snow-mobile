import 'dart:typed_data';

class ProtobufVarint32FrameDecoder {
  Uint8List decode(Uint8List data) {
    print("read data:$data");
    MessageDataInfo messageInfo = _getMessageLength(data);
    int headLength = messageInfo.headLength;
    int bodyLength = messageInfo.messageLength;
    int end = headLength + bodyLength;
    Uint8List messageData = data.sublist(messageInfo.headLength, end);
    return messageData;
  }

  //获取 head 占位数，和 message 占位数
  MessageDataInfo _getMessageLength(Uint8List data) {
    ByteData byteData = data.buffer.asByteData();
    int index = 0;
    int tmp = byteData.getUint8(index);
    int result = 0;
    if (tmp >= 0) {
      result = tmp;
    } else {
      result = tmp & 127;
      tmp = byteData.getUint8(++index);
      if (tmp >= 0) {
        result |= tmp << 7;
      } else {
        result |= (tmp & 127) << 7;
        tmp = byteData.getUint8(++index);
        if (tmp >= 0) {
          result |= tmp << 14;
        } else {
          result |= (tmp & 127) << 14;
          tmp = byteData.getUint8(++index);
          if (tmp > 0) {
            result |= tmp << 21;
          } else {
            result |= (tmp & 127) << 21;
            tmp = byteData.getUint8(++index);
            result |= tmp << 28;
            if (tmp < 0) {
              throw Exception("malformed varint.");
            }
          }
        }
      }
    }
    int headLength = index + 1;
    print("_getMessageLength head length:$headLength");
    return MessageDataInfo(headLength, result);
  }
}

class MessageDataInfo {
  int headLength;
  int messageLength;

  MessageDataInfo(this.headLength, this.messageLength);
}
