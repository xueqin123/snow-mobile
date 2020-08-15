import 'package:snowclient/generated/json/base/json_convert_content.dart';

class RspLoginEntity with JsonConvert<RspLoginEntity> {
	String appKey;
	String uid;
	String token;
}
