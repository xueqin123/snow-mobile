import 'dart:convert';

import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';
import 'package:fixnum/fixnum.dart';
import '../../snow_im_context.dart';

class CustomMessageEncoder extends OutboundEncoder<CustomMessage> {
  @override
  encodeSend(SnowIMContext context, CustomMessage customMessage) {
    customMessage.direction = Direction.SEND;
    customMessage.time = SnowIMUtils.currentTime();
    SLog.v("CustomMessageEncoder encode()");
    MessageContent messageContent = MessageContent();
    messageContent.uid = context.selfUid;
    messageContent.content = jsonEncode(customMessage.encode());
    messageContent.time = SnowIMUtils.generateCidByTime(customMessage.time);
    messageContent.type = customMessage.type;
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.cid = Int64(customMessage.cid);
    upDownMessage.fromUid = context.selfUid;
    if (customMessage.conversationType == ConversationType.SINGLE) {
      upDownMessage.targetUid = customMessage.targetId;
    } else {
      upDownMessage.conversationId = customMessage.targetId;
    }
    upDownMessage.groupId = "";
    upDownMessage.conversationType = customMessage.conversationType;
    upDownMessage.content = messageContent;

    SnowMessage snowMessage = SnowMessage();
    snowMessage.type = SnowMessage_Type.UpDownMessage;
    snowMessage.upDownMessage = upDownMessage;
    if (next != null) {
      next.encodeSend(context, snowMessage);
    }
  }
}
