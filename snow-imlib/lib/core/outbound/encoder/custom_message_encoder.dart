import 'dart:convert';

import 'package:imlib/core/outbound/outbound_encoder.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:imlib/utils/snow_im_utils.dart';
import 'package:fixnum/fixnum.dart';
import '../../../imlib.dart';
import '../../snow_im_context.dart';

class CustomMessageEncoder extends OutboundEncoder<CustomMessage> {
  @override
  encodeSend(SnowIMContext context, CustomMessage customMessage) async{
    customMessage.id = customMessage.cid;
    customMessage.uid = context.selfUid;
    customMessage.status = SendStatus.SENDING;
    customMessage.direction = Direction.SEND;
    customMessage.time = SnowIMUtils.currentTime();
    SLog.v("CustomMessageEncoder encode()");
    MessageContent messageContent = MessageContent();
    messageContent.uid = context.selfUid;
    messageContent.content = customMessage.encode();
    messageContent.time = Int64(SnowIMUtils.currentTime());
    messageContent.type = customMessage.type;
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.cid = Int64(customMessage.cid);
    upDownMessage.fromUid = context.selfUid;
    if (customMessage.conversationType == ConversationType.SINGLE) {
      upDownMessage.targetUid = customMessage.targetId;
    } else if(customMessage.conversationType == ConversationType.GROUP){
      upDownMessage.conversationId = customMessage.conversationId;
    }
    context.onSendStatusChanged(SendStatus.SENDING, customMessage);
    customMessage.status = SendStatus.PERSIST;
    await SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().insertSendMessage(customMessage.targetId, customMessage);
    context.onSendStatusChanged(SendStatus.PERSIST, customMessage);
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
