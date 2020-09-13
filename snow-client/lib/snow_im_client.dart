import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/messages/image_message.dart';
import 'package:snowclient/messages/text_message.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/service/upload_service.dart';
import 'package:snowclient/upload/media_compress_utils.dart';

typedef SendProgressBlock = Function(int cur, int total, CustomMessage sendingMsg);

class SnowImClient {
  static sendTextMessage(String targetId, String text, ConversationType conversationType, SendBlock b) {
    TextMessage textMessage = TextMessage(text: text);
    SnowIMLib.sendMessage(targetId, conversationType, textMessage, block: b);
  }

  static sendImageMessage(String targetId, ConversationType conversationType, String localPath, bool isOriginal, SendBlock b, SendProgressBlock processBlock) async {
    if (localPath == null || localPath.isEmpty) {
      SLog.i("SnowImClient localPath isEmpty!");
      return;
    }
    ImageMessage imageMessage = ImageMessage(localPath: localPath);
    imageMessage.isOriginal = isOriginal;
    String thumbPath = await MediaCompressUtils.compressImageByTargetWidth(localPath, 40);
    File thumbFile = File(thumbPath);
    Uint8List bytes = thumbFile.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    imageMessage.bytes = bytes;
    imageMessage.base64 = base64Image;

    SnowIMLib.sendMessage(targetId, conversationType, imageMessage, block: b, prepare: (sendingMessage) async {
      ImageMessage imageMessage = sendingMessage;
      String upLoadFile = await MediaCompressUtils.compressImageByTargetWidth(imageMessage.localPath, 480);
      UploadService uploadService = HttpManager.getInstance().getService<UploadService>();
      String remoteUrl = await uploadService.upLoadImage(upLoadFile, progress: (cur, total) {
        processBlock(cur, total, sendingMessage);
      });
      imageMessage.remoteUrl = remoteUrl;
      return imageMessage;
    });
  }
}
