import 'dart:typed_data';

import 'package:imlib/utils/s_log.dart';

class ProtobufVarint32FrameDecoder {
  Uint8List restData = Uint8List(0);

  List<Uint8List> decode(Uint8List data) {
    SLog.v("ProtobufVarint32FrameDecoder start !");
    SLog.v("ProtobufVarint32FrameDecoder decode data length:${data.length}");
    if (restData.length == 0) {
      restData = data;
    } else {
      Uint8List list = Uint8List(restData.length + data.length);
      for(int i =0;i<list.length;i++){
        if(i<restData.length){
          list[i] = restData[i];
        }else{
          list[i] = data[i - restData.length];
        }
      }
      restData = list;
    }
    List<Uint8List> packages = List<Uint8List>();
    while (restData != null) {
      MessageDataInfo messageInfo = _getMessageLength(restData);
      SLog.v("ProtobufVarint32FrameDecoder decode MessageDataInfo: $messageInfo");
      int subStart = messageInfo.headLength;
      int subEnd = messageInfo.messageLength + messageInfo.headLength;
      if (subEnd == restData.length) {
        Uint8List pack = restData.sublist(subStart, subEnd);
        packages.add(pack);
        restData = Uint8List(0);
        break;
      } else if (subEnd < restData.length) {
        Uint8List pack = restData.sublist(subStart, subEnd);
        restData = restData.sublist(subEnd);
        packages.add(pack);
      } else {
        break;
      }
    }
    SLog.v("ProtobufVarint32FrameDecoder decode packages length: ${packages.length}");
    SLog.v("ProtobufVarint32FrameDecoder decode end !");
    return packages;
  }

  //获取 head 占位数，和 message 占位数
  MessageDataInfo _getMessageLength(Uint8List data) {
    SLog.i("_getMessageLength data: ${data.length}");
    ByteData byteData = data.buffer.asByteData();
    int index = 0;
    int tmp = byteData.getInt8(index);
    int result = 0;
    if (tmp >= 0) {
      result = tmp;
    } else {
      result = tmp & 127;
      tmp = byteData.getInt8(++index);
      if (tmp >= 0) {
        result |= tmp << 7;
      } else {
        result |= (tmp & 127) << 7;
        tmp = byteData.getInt8(++index);
        if (tmp >= 0) {
          result |= tmp << 14;
        } else {
          result |= (tmp & 127) << 14;
          tmp = byteData.getInt8(++index);
          if (tmp > 0) {
            result |= tmp << 21;
          } else {
            result |= (tmp & 127) << 21;
            tmp = byteData.getInt8(++index);
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
