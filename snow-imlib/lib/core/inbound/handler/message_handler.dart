import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/message/message_content.dart';
import 'package:imlib/message/messsage_manager.dart';
import 'package:imlib/proto/message.pb.dart';
import 'dart:convert';

class MessageHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.UpDownMessage) {
      UpDownMessage upDownMessage = snowMessage.upDownMessage;
      MessageContent messageContent = upDownMessage.content;
      CustomMessage emptyMessage = MessageManager.getInstance().getMessageProvider(messageContent.type)();
      emptyMessage.id = upDownMessage.id.toInt();
      emptyMessage.uid = messageContent.uid;
      emptyMessage.type = messageContent.type;
      emptyMessage.content = messageContent.content;
      emptyMessage.conversationId = upDownMessage.conversationId;
      emptyMessage.targetId = upDownMessage.targetUid;
      emptyMessage.chatType = convertChatType(upDownMessage.conversationType);
      emptyMessage.decode(jsonDecode(emptyMessage.content));
    }
    return false;
  }

  ChatType convertChatType(ConversationType conversationType) {
    ChatType chatType;
    switch (conversationType) {
      case ConversationType.SINGLE:
        chatType = ChatType.SINGLE;
        break;
      case ConversationType.GROUP:
        chatType = ChatType.GROUP;
        break;
    }
    return chatType;
  }
}
