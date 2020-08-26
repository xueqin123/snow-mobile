import 'package:snowclient/generated/json/base/json_convert_content.dart';

class GroupEntity with JsonConvert<GroupEntity> {
	String groupId;
	String name;
	String portrait;
	String conversationId;
	String ownerUid;
	int status;
}
