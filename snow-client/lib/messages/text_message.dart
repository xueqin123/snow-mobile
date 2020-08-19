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
    Map<String, dynamic> json = Map();
    json["content"] = content;
    return json;
  }
}

Widget buildTextMessageWidget(CustomMessage customMessage) {
  return Container(
    height: 35,
    decoration: ShapeDecoration(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        customMessage.content,
        style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

TextMessage buildEmptyTextMessage() {
  return TextMessage();
}
