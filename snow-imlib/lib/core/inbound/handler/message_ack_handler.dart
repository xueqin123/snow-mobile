import 'package:imlib/core/inbound/inbound_handler.dart';
import 'package:imlib/core/snow_im_context.dart';
import 'package:imlib/data/db/model/model_manager.dart';
import 'package:imlib/data/db/model/snow_message_model.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';

class MessageAckHandler extends InboundHandler {
  @override
  bool onRead(SnowIMContext context, SnowMessage snowMessage){
    if (snowMessage.type == SnowMessage_Type.MessageAck) {
      MessageAck messageAck = snowMessage.messageAck;
      _handleSendStatus(context,messageAck);
      return true;
    }
    return false;
  }

  _handleSendStatus(SnowIMContext context,MessageAck messageAck) async{
    SnowMessageModel model = SnowIMModelManager.getInstance().getModel<SnowMessageModel>();
    if(messageAck.code == Code.SUCCESS){
      await model.updateSendMessage(messageAck.id.toInt(), SendStatus.SUCCESS, messageAck.cid.toInt());
      CustomMessage customMessage = await model.getCustomMessageById(messageAck.id.toInt());
      customMessage.cid = messageAck.cid.toInt();
      context.onSendStatusChanged(SendStatus.SUCCESS, customMessage);
    }else{
      await model.updateSendMessage(messageAck.id.toInt(), SendStatus.FAILED, messageAck.cid.toInt());
      CustomMessage customMessage = await model.getCustomMessageById(messageAck.id.toInt());
      customMessage.cid = messageAck.cid.toInt();
      context.onSendStatusChanged(SendStatus.FAILED, customMessage);
    }
    context.onMessageAck(messageAck.cid, messageAck.code);
  }
}
