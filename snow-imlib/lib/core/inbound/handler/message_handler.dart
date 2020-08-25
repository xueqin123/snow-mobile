import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/proto/message.pb.dart';

import 'package:imlib/utils/snow_im_utils.dart';

class MessageHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage) {
    if (snowMessage.type == SnowMessage_Type.UpDownMessage) {
      UpDownMessage upDownMessage = snowMessage.upDownMessage;
      _initConversationIfNeedAndSaveMessage(upDownMessage);
      context.sendSnowMessage(_buildMessageAck(upDownMessage));
      return true;
    }
    return false;
  }

  _initConversationIfNeedAndSaveMessage(UpDownMessage upDownMessage) async {
    MessageContent messageContent = upDownMessage.content;
    await SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().insertOrUpdateConversationByUpDown(upDownMessage); //更新会话表
    SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().saveReceivedMessageContent(upDownMessage.conversationId, messageContent); //保存消息
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
