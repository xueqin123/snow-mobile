import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/message_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class MessageViewModel with ChangeNotifier {
  TextEditingController _sendTextController = TextEditingController();

  get sendTextController => _sendTextController;
  List<CustomMessage> data;
  String targetId;
  ConversationType chatType;
  String chatName = "";
  ContactModel contactModel;
  MessageModel messageModel;
  Map<int, ProgressViewModel> progressmap = Map();

  MessageViewModel(this.targetId, this.chatType) {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    messageModel = ModelManager.getInstance().getModel<MessageModel>();
  }

  StreamController<UserEntity> getUserController() {
    return contactModel.getUserController(targetId);
  }

  Future<String> getChatName() async {
    SLog.i("MessageViewModel getChatName() chatType = $chatType");
    if (chatType == ConversationType.SINGLE) {
      UserEntity userEntity = await contactModel.getUserById(targetId);
      return userEntity.name;
    } else if (chatType == ConversationType.GROUP) {
      GroupEntity groupEntity = await SnowIMLib.getGroupDetailByConversationId(targetId);
      SLog.i("getChatName groupEntity:$groupEntity");
      return groupEntity.detail.name;
    }
  }

  StreamController<List<MessageWrapper>> getMessageController(String targetId, ConversationType conversationType) {
    return messageModel.getMessageController(targetId, conversationType);
  }

  sendTextMessage() {
    String text = _sendTextController.text;
    if (text == null || text.isEmpty) {
      return;
    }
    messageModel.sendTextMessage(targetId, text, chatType);
    _sendTextController.clear();
  }

  sendImageMessage(String localPath) {
    messageModel.sendImageMessage(targetId, localPath, chatType, _messageProgressBlock);
  }

  ProgressViewModel getProgressViewModel(int cid) {
    SLog.i("getProgressViewModel cid:$cid");
    if (cid == null) {
      return ProgressViewModel();
    }
    progressmap[cid] = ProgressViewModel();
    return progressmap[cid];
  }

  _messageProgressBlock(int cur, int total, CustomMessage customMessage) {
//    SLog.i("_messageProgressBlock cid:${customMessage.cid} cur:$cur total:$total ");
    double progress = (cur / total) * 100;
    int cid = customMessage.cid;
    if (progressmap.containsKey(cid)) {
      progressmap[cid].updateProgress(ProgressInfo(cid, progress.toInt()));
    }
  }
}

class ProgressViewModel with ChangeNotifier {
  ProgressInfo progressInfo = ProgressInfo(0, 0);

  updateProgress(ProgressInfo cur) {
    SLog.i("ProgressViewModel updateProgress cur:${cur.progress}");
    progressInfo = cur;
    notifyListeners();
  }
}

class ProgressInfo {
  int cid;
  int progress;
  ProgressInfo(this.cid, this.progress);
}
