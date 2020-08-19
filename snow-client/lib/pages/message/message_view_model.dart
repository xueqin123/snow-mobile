import 'package:flutter/cupertino.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/messages/text_message.dart';

class MessageViewModel with ChangeNotifier {
  TextEditingController _sendTextController = TextEditingController();

  get sendTextController => _sendTextController;
  List<CustomMessage> data;
  String targetId;
  ChatType chatType;
  String chatName = "";

  MessageViewModel(this.targetId, this.chatType) {
    initChatName();
    data = List<CustomMessage>();
    data.sort((a, b) => a.time.compareTo(b.time));
    SnowIMLib.getCustomMessageStream().listen((event) => _onMessageReceive(event));
  }

  initChatName() {
    if (chatType == ChatType.SINGLE) {
      return ModelManager.getInstance().getModel<ContactModel>().getUserController(targetId).stream.listen((event) {
        chatName = event.name;
        notifyListeners();
      });
    } else if(chatType == ChatType.GROUP){
      //todo group
    }
  }

  _onMessageReceive(CustomMessage msg) {
    if (data.length == 0) {
      data.add(msg);
    } else {
      int index = data.length - 1;
      while (index >= 0) {
        if (data[index].time < msg.time) {
          if (index < data.length - 1) {
            data.insert(index + 1, msg);
          } else {
            data.add(msg);
          }
          break;
        }
        index--;
      }
    }
    SLog.i("MessageViewModel _onMessageReceive data.length = ${data.length}");
    notifyListeners();
  }

  sendTextMessage() {
    TextMessage textMessage = TextMessage(content: _sendTextController.text);
    textMessage.targetId = targetId;
    textMessage.chatType = chatType;
    textMessage.type = textMessage.runtimeType.toString();
    textMessage.targetId = SnowIMLib.sendMessage(textMessage, block: (statue) {
      SLog.i("send status:$statue");
    });
  }
}
