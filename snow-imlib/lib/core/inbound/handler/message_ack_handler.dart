import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_im_message_model.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';

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
    SnowIMMessageModel model = SnowIMModelManager.getInstance().getModel<SnowIMMessageModel>();
    if (messageAck.code == Code.SUCCESS) {
      CustomMessage customMessage = await model.updateSendMessage(messageAck.id.toInt(), messageAck.conversationId, SendStatus.SUCCESS, messageAck.cid.toInt());
      customMessage.cid = messageAck.cid.toInt();
      customMessage.status = SendStatus.SUCCESS;
      context.onSendStatusChanged(SendStatus.SUCCESS,customMessage);
    } else {
      CustomMessage customMessage = await model.updateSendMessage(messageAck.cid.toInt(), messageAck.conversationId, SendStatus.FAILED, messageAck.cid.toInt());
      customMessage.cid = messageAck.cid.toInt();
      customMessage.targetId = messageAck.conversationId;
      context.onSendStatusChanged(SendStatus.FAILED, customMessage);
    }
    context.onMessageAck(messageAck.cid, messageAck.code);
  }


}
