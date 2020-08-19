import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';

class ChatViewModel with ChangeNotifier {
  StreamController<List<ConversationEntity>> getAllConversationStream() {
    return SnowIMLib.getConversationController();
  }
}
