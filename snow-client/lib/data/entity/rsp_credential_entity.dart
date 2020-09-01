import 'package:snowclient/generated/json/base/json_convert_content.dart';

class RspCredentialEntity with JsonConvert<RspCredentialEntity> {
	String tmpSecretId;
	String tmpSecretKey;
	String sessionToken;
}
