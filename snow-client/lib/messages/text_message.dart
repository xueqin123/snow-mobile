import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/utils/s_log.dart';

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
  return Flexible(
    child: DecoratedBox(
      decoration: const BoxDecoration(color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(5.0),),
      ),
      child: Baseline(
        baseline: 32.0,
        baselineType: TextBaseline.alphabetic,
        child: Text(
          textMessage.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

String buildTextLast(String lastContent) {
  SLog.i("buildTextLast lastContent: $lastContent");
  return jsonDecode(lastContent)["text"];
}

TextMessage buildEmptyTextMessage() {
  return TextMessage();
}
