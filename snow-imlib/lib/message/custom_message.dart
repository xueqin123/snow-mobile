import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';

abstract class CustomMessage {
  int id;
  String uid;
  int cid;
  String type;
  String targetId;
  String conversationId;
  ConversationType conversationType;
  int time;
  Direction direction;
  SendStatus status = SendStatus.SENDING;
  String content;

  Map<String, dynamic> encode();

  decode(Map<String, dynamic> json);
}

enum Direction { SEND, RECEIVE }
