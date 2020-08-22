import 'package:imlib/proto/message.pb.dart';

class Conversation {
  String conversationId;
  ConversationType type;
  List<String> uidList;
  String groupId;
  String readMsgId;
  String lastId;
  String lastUid;
  String lastType;
  String lastContent;
  String lastTime;
  String time;

  String getUidListString() {
    String uids = "";
    uidList.forEach((element) {
      uids += "$element,";
    });
    return uids.substring(0, uids.length - 1);
  }

  setUidListString(String uids) {
    uidList = uids.split(",");
  }
}
