import 'dart:ffi';

import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_conversation_model.dart';
import 'package:imlib/data/db/model/snow_message_model.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:fixnum/fixnum.dart';

class MessageAckHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.MessageAck) {
      MessageAck messageAck = snowMessage.messageAck;
      _handleSendStatus(context, messageAck);
      return true;
    }
    return false;
  }

  _handleSendStatus(SnowIMContext context, MessageAck messageAck) async {
    SnowMessageModel model = SnowIMModelManager.getInstance().getModel<SnowMessageModel>();
    if (messageAck.code == Code.SUCCESS) {
      CustomMessage customMessage = await model.updateSendMessage(messageAck.id.toInt(), messageAck.conversationId, SendStatus.SUCCESS, messageAck.cid.toInt());
      customMessage.cid = messageAck.cid.toInt();
      context.onSendStatusChanged(SendStatus.SUCCESS, customMessage);
      _insertOrUpdateConversation(messageAck.conversationId, customMessage);
    } else {
      CustomMessage customMessage = await model.updateSendMessage(messageAck.id.toInt(), messageAck.conversationId, SendStatus.FAILED, messageAck.cid.toInt());
      customMessage.cid = messageAck.cid.toInt();
      context.onSendStatusChanged(SendStatus.FAILED, customMessage);
    }



    context.onMessageAck(messageAck.cid, messageAck.code);
  }

  _insertOrUpdateConversation(String conversationId,CustomMessage customMessage){
    MessageContent messageContent = MessageContent();
    messageContent.content = customMessage.content;
    messageContent.uid = customMessage.uid;
    messageContent.type = customMessage.type;
    messageContent.time = Int64(customMessage.time);
    messageContent.id = Int64(customMessage.id);
    UpDownMessage upDownMessage = UpDownMessage();
    upDownMessage.id = Int64(customMessage.id);
    upDownMessage.content= messageContent;
    upDownMessage.conversationId = conversationId;
    upDownMessage.targetUid = customMessage.targetId;
    upDownMessage.conversationType = customMessage.conversationType;
    upDownMessage.fromUid = customMessage.uid;
    upDownMessage.cid = Int64(customMessage.cid);
    SnowConversationModel conversationModel = SnowIMModelManager.getInstance().getModel<SnowConversationModel>();
    conversationModel.insertOrUpdateConversation(upDownMessage);
  }
}
