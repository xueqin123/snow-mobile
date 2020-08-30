import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_group_model.dart';
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
    SnowIMGroupModel groupModel = SnowIMModelManager.getInstance().getModel<SnowIMGroupModel>();
    bool isExistGroup = await groupModel.isGroupExist(upDownMessage.groupId);
    if (upDownMessage.conversationType == ConversationType.GROUP && !isExistGroup) {
      await groupModel.syncGroupByGroupId(upDownMessage.groupId);
    }
    await SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().insertOrUpdateConversationByUpDown(upDownMessage); //更新会话表
    await SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>().saveReceivedMessageContent(upDownMessage.conversationId, messageContent); //保存消息
    SnowIMModelManager.getInstance().getModel<SnowIMConversationModel>().onUnReadCountChanged();
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
