import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/message/message_manager.dart';
import 'package:imlib/proto/message.pb.dart';
import 'dart:convert';

import 'package:imlib/utils/snow_im_utils.dart';

class MessageHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.UpDownMessage) {
      UpDownMessage upDownMessage = snowMessage.upDownMessage;
      MessageContent messageContent = upDownMessage.content;
      CustomMessage readyMessage = MessageManager.getInstance().getMessageProvider(messageContent.type)();
      readyMessage.id = upDownMessage.id.toInt();
      readyMessage.uid = messageContent.uid;
      readyMessage.type = messageContent.type;
      readyMessage.content = messageContent.content;
      readyMessage.conversationId = upDownMessage.conversationId;
      readyMessage.targetId = upDownMessage.targetUid;
      readyMessage.chatType = convertChatType(upDownMessage.conversationType);
      readyMessage.decode(jsonDecode(readyMessage.content));
      readyMessage.direction = _getDirection(context, messageContent.uid);
      readyMessage.time = messageContent.time.toInt();
      context.getCustomMessageController().sink.add(readyMessage);
      context.sendSnowMessage(_buildMessageAck(upDownMessage));
      return true;
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

  Direction _getDirection(SnowIMContext context, String sendId) {
    if (sendId == context.selfUid) {
      return Direction.SEND;
    } else {
      return Direction.RECEIVE;
    }
  }

  SnowMessage _buildMessageAck(UpDownMessage upDownMessage) {
    MessageAck messageAck = MessageAck();
    messageAck.id = upDownMessage.id;
    messageAck.cid = SnowIMUtils.generateCid();
    messageAck.conversationId = upDownMessage.conversationId;
    messageAck.code = Code.SUCCESS;
    messageAck.time = SnowIMUtils.generateCid();
    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.MessageAck;
    snowMessage.messageAck = messageAck;
    return snowMessage;
  }
}
