import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:snowclient/generated/l10n.dart';

class ImageMessage extends CustomMessage {
  String localPath;
  String remoteUrl;
  String base64;
  bool isOriginal;
  Uint8List bytes;

  ImageMessage({this.localPath});

  @override
  decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    remoteUrl = map["remoteUrl"];
    base64 = map["base64"];
    isOriginal = map["isOriginal"];
    bytes = base64Decode(base64);
  }

  @override
  String encode() {
    Map<String, dynamic> map = Map();
    map["remoteUrl"] = remoteUrl;
    map["base64"] = base64;
    map["isOriginal"] = isOriginal;
    return jsonEncode(map);
  }
}

Widget buildImageMessageWidget(CustomMessage customMessage) {
  ImageMessage imageMessage = customMessage;
  return Stack(
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 250,
        ),
        child: Image.memory(imageMessage.bytes),
      ),
    ],
  );
}

String buildImageLast(String lastContent) {
  return S.current.image;
}

ImageMessage buildEmptyImageMessage() {
  return ImageMessage();
}
