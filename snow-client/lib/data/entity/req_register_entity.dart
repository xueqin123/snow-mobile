import 'package:snowclient/generated/json/base/json_convert_content.dart';

class ReqRegisterEntity with JsonConvert<ReqRegisterEntity> {
	String name;
	String username;
	int type;
	String password;
	String portrait;
}
