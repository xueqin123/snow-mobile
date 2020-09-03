import 'package:snowclient/generated/json/base/json_convert_content.dart';

class ReqUserEntity with JsonConvert<ReqUserEntity> {
	String name;
	String username;
	int type;
	String password;
	String portrait;
}
