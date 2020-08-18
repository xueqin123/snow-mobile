abstract class CustomMessage {
  int id;
  String uid;
  String type;
  String content;
  String conversationId;
  String targetId;
  String groupId;
  ChatType chatType;
  int time;
  Direction direction;

  Map<String, dynamic> encode();

  decode(Map<String, dynamic> json);
}

enum ChatType {
  SINGLE,
  GROUP,
}

enum Direction { SEND, RECEIVE }
