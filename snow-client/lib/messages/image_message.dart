import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:snowclient/generated/l10n.dart';

class ImageMessage extends CustomMessage {
  String localPath;
  String remoteUrl;
  String base64;
  bool isOriginal;

  ImageMessage({this.localPath});

  @override
  decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    remoteUrl = map["remoteUrl"];
    base64 = map["base64"];
    isOriginal = map["isOriginal"];
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
  return ConstrainedBox(
    constraints: BoxConstraints(
        maxWidth: 250,
    ),
    child: Image.memory(base64Decode(imageMessage.base64)),
  );
}

String buildImageLast(String lastContent) {
  return S.current.image;
}

ImageMessage buildEmptyImageMessage() {
  return ImageMessage();
}
