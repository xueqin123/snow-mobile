import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/messages/image_message.dart';
import 'package:snowclient/messages/text_message.dart';
import 'package:snowclient/upload/media_compress_utils.dart';

typedef SendProcessBlock = Function(int cur, int total);

class SnowImClient {
  static sendTextMessage(String targetId, String text, ConversationType conversationType, SendBlock b) {
    TextMessage textMessage = TextMessage(text: text);
    SnowIMLib.sendMessage(targetId, conversationType, textMessage, block: b);
  }

  static sendImageMessage(String targetId, ConversationType conversationType, String localPath, bool isOriginal, SendBlock b, SendProcessBlock processBlock) async {
    ImageMessage imageMessage = ImageMessage(localPath: localPath);
    imageMessage.isOriginal = isOriginal;
    String thumbPath = await MediaCompressUtils.compressImageByTargetWidth(localPath, 40);
    File thumbFile = File(thumbPath);
    String base64Image = base64Encode(thumbFile.readAsBytesSync());
    imageMessage.base64 = base64Image;
    SnowIMLib.sendMessage(targetId, conversationType, imageMessage, block: b);
  }
}
