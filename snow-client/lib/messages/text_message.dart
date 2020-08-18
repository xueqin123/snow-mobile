import 'package:imlib/message/message_content.dart';

class TextMessage extends CustomMessage {
  String content;

  TextMessage(this.content);

  @override
  decode(Map<String, dynamic> json) {
    content = json["content"];
  }

  @override
  Map<String, dynamic> encode() {
    Map json = Map();
    json["content"] = content;
    return json;
  }
}
