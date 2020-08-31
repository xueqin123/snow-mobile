import 'package:flutter/cupertino.dart';
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ChatDetailViewModel with ChangeNotifier {
  ContactModel contactModel;
  String targetId;
  ConversationType conversationType;

  ChatDetailViewModel(this.targetId, this.conversationType) {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
  }

  Future<String> getChatName() async {
    SLog.i("MessageViewModel getChatName() conversationType = $conversationType");
    if (conversationType == ConversationType.SINGLE) {
      UserEntity userEntity = await contactModel.getUserById(targetId);
      return userEntity.name;
    } else if (conversationType == ConversationType.GROUP) {
      GroupEntity groupEntity = await SnowIMLib.getGroupDetailByConversationId(targetId);
      SLog.i("getChatName groupEntity:$groupEntity");
      return groupEntity.detail.name;
    }
  }


  Future<bool> dismissGroup(String conversationId) async{
   GroupEntity groupEntity = await SnowIMLib.getGroupDetailByConversationId(conversationId);
   return SnowIMLib.dismissGroup(groupEntity.groupId);
  }
}
