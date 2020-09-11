import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/utils/s_log.dart';

class TextMessage extends CustomMessage {
  String text;

  TextMessage({this.text});

  @override
  decode(String json) {
   Map<String,dynamic> map = jsonDecode(json);
   text = map["text"];
  }

  @override
  String encode() {
    Map<String,dynamic>map = Map();
    map["text"] = text;
    return jsonEncode(map);
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
