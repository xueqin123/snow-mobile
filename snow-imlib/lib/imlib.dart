library imlib;
export 'package:imlib/imlib.dart';
export 'package:imlib/utils/s_log.dart';

import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/message/message_content.dart';
import 'package:imlib/message/messsage_manager.dart';


typedef SendBlock = Function(SendStatus status);
typedef MessageProvider = CustomMessage Function();

class SnowIMLib {
  static connect(String token, uid) async {
    return SnowIMContext.getInstance().connect(token, uid);
  }

  static getConnectStatusStream() {
    return SnowIMContext.getInstance().getConnectStatusController();
  }

  static sendMessage(CustomMessage customMessage, {SendBlock block}) {
    return SnowIMContext.getInstance().sendCustomMessage(customMessage, block);
  }

  static registerMessage(String messageType, MessageProvider messageProvider) {
    MessageManager.getInstance().registerMessageProvider(messageType, messageProvider);
  }

  static String getCurrentUid() {
    return SnowIMContext.getInstance().selfUid;
  }
}

enum SendStatus { SENDING, SUCCESS, FAILED }
