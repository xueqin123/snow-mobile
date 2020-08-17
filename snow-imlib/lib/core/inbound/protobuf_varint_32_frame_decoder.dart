import 'dart:typed_data';

import 'package:imlib/utils/s_log.dart';

class ProtobufVarint32FrameDecoder {
  List<Uint8List> decode(Uint8List data) {
    SLog.i("read start !");
    SLog.i("read data length:${data.length}");
    List<Uint8List> packages = List<Uint8List>();
    Uint8List restData = data;
    while (restData != null) {
      //拆包
      MessageDataInfo messageInfo = _getMessageLength(restData);
      SLog.i("read MessageDataInfo: $messageInfo");
      int subStart = messageInfo.headLength;
      int subEnd = messageInfo.messageLength + messageInfo.headLength;
      if (subEnd == restData.length) {
        Uint8List pack = data.sublist(subStart, subEnd);
        packages.add(pack);
        restData = null;
      } else if (subEnd < restData.length) {
        Uint8List pack = data.sublist(subStart, subEnd);
        restData = restData.sublist(subEnd);
        packages.add(pack);
      } else {
        restData = null;
      }
    }
    SLog.i("read packages length: ${packages.length}");
    SLog.i("read end !");
    return packages;
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
    return MessageDataInfo(headLength, result);
  }
}

class MessageDataInfo {
  int headLength;
  int messageLength;

  MessageDataInfo(this.headLength, this.messageLength);

  @override
  String toString() {
    return 'MessageDataInfo{headLength: $headLength, messageLength: $messageLength}';
  }
}
