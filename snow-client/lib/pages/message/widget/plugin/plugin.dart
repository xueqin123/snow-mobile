import 'package:flutter/material.dart';
import 'package:imlib/proto/message.pb.dart';

abstract class Plugin {
  int getOrder();

  String getName();

  Widget getIcon();

  onClick(BuildContext context,String conversationId, ConversationType conversationType);
}
