import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';

import '../../snow_im_context.dart';

class CustomMessageEncoder extends OutboundEncoder<CustomMessage> {
  @override
  encodeSend(SnowIMContext context, CustomMessage customMessage) {
    SLog.v("CustomMessageEncoder encode()");
    MessageContent messageContent = MessageContent();
    messageContent.uid = context.selfUid;
    messageContent.content = customMessage.encode().toString();
    messageContent.time = SnowIMUtils.currentTime();
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.cid = SnowIMUtils.currentTime();
    upDownMessage.fromUid = context.selfUid;
    upDownMessage.targetUid = customMessage.targetId;
    if (customMessage.groupId == null) {
      upDownMessage.groupId = "";
    } else {
      upDownMessage.groupId = customMessage.groupId;
    }
    if (customMessage.conversationId == null) {
      upDownMessage.conversationId = "";
    } else {
      upDownMessage.conversationId = customMessage.conversationId;
    }
    upDownMessage.conversationType = _convertMessageType(customMessage.chatType);
    upDownMessage.content = messageContent;

    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.UpDownMessage;
    snowMessage.upDownMessage = upDownMessage;
    context.getCustomMessageController().sink.add(customMessage);
    customMessage.direction = Direction.SEND;
    if (next != null) {
      next.encodeSend(context, snowMessage);
    }
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
