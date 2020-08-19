import 'dart:convert';

class ConversationEntity {
  String conversationId;
  int type;
  List<String> uidList;
  String groupId;
  String readMsgId;
  String lastId;
  String lastUid;
  String lastType;
  String lastContent;
  String lastTime;
  String time;

  String getUidList() {
    String uids = "";
    uidList.forEach((element) {
      uids += "$element,";
    });
    return uids.substring(0, uids.length - 1);
  }

  setUidList(String uids) {
    uidList = uids.split(",");
  }
}
