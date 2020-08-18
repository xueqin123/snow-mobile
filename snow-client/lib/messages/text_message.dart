import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';

class TextMessage extends CustomMessage {
  String content;

  TextMessage({this.content});

  @override
  decode(Map<String, dynamic> json) {
    content = json["content"];
  }

  @override
  Map<String, dynamic> encode() {
    Map<String,dynamic> json = Map();
    json["content"] = content;
    return json;
  }
}

Widget buildTextMessageWidget(CustomMessage customMessage) {
  return Container(
    height: 60,
    child: Text(
      customMessage.content,
      style: TextStyle(fontSize: 20),
    ),
  );
}

TextMessage buildEmptyTextMessage() {
  return TextMessage();
}
