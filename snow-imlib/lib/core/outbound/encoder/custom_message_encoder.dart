import 'dart:convert';

import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/message/message_content.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

import '../../snow_im_context.dart';

class CustomMessageEncoder extends OutboundEncoder<CustomMessage, SnowMessage> {
  @override
  SnowMessage encode(SnowIMContext context, CustomMessage customMessage) {
    SLog.v("CustomMessageEncoder encode()");
    MessageContent messageContent = MessageContent();
    messageContent.uid = context.selfUid;
    messageContent.type = customMessage.runtimeType.toString();
    messageContent.content = jsonEncode(customMessage.encode());
    messageContent.time = SnowIMUtils.currentTime();

    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.cid = SnowIMUtils.currentTime();
    upDownMessage.fromUid = context.selfUid;
    upDownMessage.targetUid = customMessage.targetId;
    upDownMessage.groupId = customMessage.groupId;
    upDownMessage.conversationId = customMessage.conversationId;
    upDownMessage.conversationType = _convertMessageType(customMessage.chatType);
    upDownMessage.content = messageContent;

    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.UpDownMessage;
    snowMessage.upDownMessage = upDownMessage;
    return snowMessage;
  }

  ConversationType _convertMessageType(ChatType chatType) {
    ConversationType conversationType;
    switch (chatType) {
      case ChatType.SINGLE:
        conversationType = ConversationType.SINGLE;
        break;
      case ChatType.GROUP:
        conversationType = ConversationType.GROUP;
        break;
    }
    return conversationType;
  }
}
