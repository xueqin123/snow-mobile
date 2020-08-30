import 'package:imlib/generated/json/base/json_convert_content.dart';

class ReqGroupEntity with JsonConvert<ReqGroupEntity> {
	String groupId;
	String name;
	String portrait;
	List<String> members;
}
