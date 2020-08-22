import 'dart:async';

import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/base_model.dart';
import 'package:snowclient/pages/chat/chat_item_entity.dart';

class ChatModel extends BaseModel {
  StreamController<List<ChatItemEntity>> chatListController;
  UserDao userDao;
  List<ChatItemEntity> currentData = List<ChatItemEntity>();

  ChatModel() {
    userDao = DaoManager.getInstance().getDao<UserDao>();
    SnowIMLib.getConversationStream().listen((event) {
      _handlerData(event);
    });
  }

  _handlerData(List<Conversation> chatList) async {
    List<ChatItemEntity> itemList = await _convertChatItemEntity(chatList);
    currentData = itemList;
    if (chatListController != null) {
      chatListController.sink.add(currentData);
    }
  }

  getChatController() {
    chatListController = StreamController();
    chatListController.sink.add(currentData);
    return chatListController;
  }

  Future<List<ChatItemEntity>> _convertChatItemEntity(List<Conversation> list) async {
    List<ChatItemEntity> result = List();
    list.forEach((chatEntity) async {
      ChatItemEntity chatItemEntity = ChatItemEntity();
      chatItemEntity.conversationId = chatEntity.conversationId;
      chatItemEntity.chatType = chatEntity.type;
      chatItemEntity.lastContent = chatEntity.lastContent;
      chatItemEntity.lastTime = chatEntity.lastTime;
      if (chatEntity.type == ConversationType.SINGLE) {
        String uid = chatEntity.uidList.firstWhere((element) => element != userDao.currentUser.uid);
        print("_convertChatItemEntity uid = $uid");
        print("_convertChatItemEntity currentUid = ${userDao.currentUser.uid}");
        chatItemEntity.targetId = uid;
        UserEntity userEntity = await userDao.getUserById(uid);
        chatItemEntity.portrait = userEntity.portrait;
        chatItemEntity.chatName = userEntity.name;
        UserEntity temp = userDao.currentUser.uid == chatEntity.lastUid ? userDao.currentUser : userEntity;
        chatItemEntity.lastName = temp.name;
      } else if (chatEntity.type == ConversationType.GROUP) {}
      result.add(chatItemEntity);
    });
    return result;
  }
}
