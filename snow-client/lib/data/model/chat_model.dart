import 'dart:async';

import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/db/dao/user_dao.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/base_model.dart';
import 'package:snowclient/generated/l10n.dart';
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
      if (chatListController != null && !chatListController.isClosed) {
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
    for (Conversation conversation in list) {
      ChatItemEntity chatItemEntity = ChatItemEntity();
      chatItemEntity.conversationId = conversation.conversationId;
      chatItemEntity.chatType = conversation.type;
      SLog.i("lastContent:${conversation.lastContent} latType:${conversation.lastType}");
      if (conversation.lastType != null && conversation.lastType.isNotEmpty) {
        ConversationContentProvider provider = MessageWidgetManager.getInstance().getConversationContentProvider(conversation.lastType);
        if (provider != null) {
          chatItemEntity.lastContent = provider(conversation.lastContent);
        } else {
          chatItemEntity.lastContent = S.current.unSupportMessage;
        }
        chatItemEntity.lastTime = conversation.lastTime;
      } else {
        chatItemEntity.lastContent = "";
        chatItemEntity.lastTime = null;
      }
      chatItemEntity.unReadCount = conversation.unReadCount;
      if (conversation.type == ConversationType.SINGLE) {
        String uid = conversation.uidList.firstWhere((element) => element != userDao.currentUser.uid);
        chatItemEntity.targetId = uid;
        UserEntity userEntity = await userDao.getUserById(uid);
        chatItemEntity.portrait = userEntity.portrait;
        chatItemEntity.chatName = userEntity.name;
        UserEntity temp = userDao.currentUser.uid == conversation.lastUid ? userDao.currentUser : userEntity;
        chatItemEntity.lastName = temp.name;
      } else if (conversation.type == ConversationType.GROUP) {
        GroupEntity groupEntity = await SnowIMLib.getGroupDetailByConversationId(conversation.conversationId);
        chatItemEntity.portrait = groupEntity.detail.portrait;
        chatItemEntity.chatName = groupEntity.detail.name;
        chatItemEntity.targetId = conversation.conversationId;
        print("chatItemEntity.lastUid:${conversation.lastUid}");
        UserEntity userEntity = await userDao.getUserById(conversation.lastUid);
        if (userEntity != null) {
          chatItemEntity.lastName = userEntity.name;
        }
      }
      result.add(chatItemEntity);
    }
    SLog.i("_convertChatItemEntity() result.length = ${result.length}");
    return result;
  }
}
