import 'package:imlib/proto/message.pb.dart';

class Conversation {
  String conversationId;
  ConversationType type;
  List<String> uidList;
  String groupId;
  int readMsgId;
  int lastId;
  String lastUid;
  String lastType;
  String lastContent;
  int lastTime;
  int time;
  int unReadCount;

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
