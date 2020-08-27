import 'package:imlib/generated/json/base/json_convert_content.dart';

class GroupEntity with JsonConvert<GroupEntity> {
	String groupId;
	String conversationId;
	GroupDetail detail;
	String time;
}

class GroupDetail with JsonConvert<GroupDetail> {
	String groupId;
	String name;
	String portrait;
	List<String> member;
}
