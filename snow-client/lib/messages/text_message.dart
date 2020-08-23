import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';

class TextMessage extends CustomMessage {
  String text;

  TextMessage({this.text});

  @override
  decode(Map<String, dynamic> json) {
    text = json["text"];
  }

  @override
  Map<String, dynamic> encode() {
    Map<String, dynamic> json = Map();
    json["text"] = text;
    return json;
  }
}

Widget buildTextMessageWidget(CustomMessage customMessage) {
  TextMessage textMessage = customMessage;
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
        textMessage.text,
        style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

TextMessage buildEmptyTextMessage() {
  return TextMessage();
}
