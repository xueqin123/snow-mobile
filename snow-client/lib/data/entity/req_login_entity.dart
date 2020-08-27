import 'package:snowclient/generated/json/base/json_convert_content.dart';

class ReqLoginEntity with JsonConvert<ReqLoginEntity> {
	String username;
	String password;
}