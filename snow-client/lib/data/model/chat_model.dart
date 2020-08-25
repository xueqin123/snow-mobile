import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/base_model.dart';
import 'package:snowclient/pages/chat/chat_item_entity.dart';
import 'package:snowclient/pages/message/message_widet_manager.dart';

class ChatModel extends BaseModel {
  UserDao userDao;
  List<ChatItemEntity> data = List<ChatItemEntity>();
  ChatModel() {
    userDao = DaoManager.getInstance().getDao<UserDao>();
    SnowIMLib.getConversationStream().listen((event) async {
      List<ChatItemEntity> itemList = await _convertChatItemEntity(event);
      data = itemList;
      if(chatListController != null){
        chatListController.sink.add(data);
      }
    });
  }

  StreamController<List<ChatItemEntity>> chatListController;

  getChatController() {
    SLog.i("getChatController()");
    chatListController = StreamController<List<ChatItemEntity>>();
    chatListController.add(data);
    return chatListController;
  }



  Future<List<ChatItemEntity>> _convertChatItemEntity(List<Conversation> list) async {
    List<ChatItemEntity> result = List();
    for(Conversation conversation in list){
      ChatItemEntity chatItemEntity = ChatItemEntity();
      chatItemEntity.conversationId = conversation.conversationId;
      chatItemEntity.chatType = conversation.type;
      chatItemEntity.lastContent = MessageWidgetManager.getInstance().getConversationContentProvider(conversation.lastType)(conversation.lastContent);
      chatItemEntity.lastTime = conversation.lastTime;
      chatItemEntity.unReadCount = conversation.unReadCount;
      print("chatItemEntity.lastTime:${chatItemEntity.lastTime}");
      if (conversation.type == ConversationType.SINGLE) {
        String uid = conversation.uidList.firstWhere((element) => element != userDao.currentUser.uid);
        print("_convertChatItemEntity uid = $uid");
        print("_convertChatItemEntity currentUid = ${userDao.currentUser.uid}");
        chatItemEntity.targetId = uid;
        UserEntity userEntity = await userDao.getUserById(uid);
        print("_convertChatItemEntity userEntity = $userEntity");
        chatItemEntity.portrait = userEntity.portrait;
        chatItemEntity.chatName = userEntity.name;
        UserEntity temp = userDao.currentUser.uid == conversation.lastUid ? userDao.currentUser : userEntity;
        chatItemEntity.lastName = temp.name;
      } else if (conversation.type == ConversationType.GROUP) {

      }
      result.add(chatItemEntity);
    }
    SLog.i("_convertChatItemEntity() result.length = ${result.length}");
    return result;
  }
}
