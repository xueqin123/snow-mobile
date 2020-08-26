import 'package:snowclient/generated/json/base/json_convert_content.dart';

class GroupMemberEntity with JsonConvert<GroupMemberEntity> {
	String groupId;
	String memberUid;
	String createDate;
	String updateDate;
	int status;
}
