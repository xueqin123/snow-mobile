import 'package:snowclient/generated/json/base/json_convert_content.dart';
import 'package:snowclient/generated/json/base/json_field.dart';

class UserEntity with JsonConvert<UserEntity> {
	String uid;
	String username;
	@JSONField(name: "create_dt")
	String createDt;
	@JSONField(name: "update_dt")
	String updateDt;
	String name;
	String portrait;
	int state;
	int type;
	@override
  String toString() {
    return 'UserEntity{uid: $uid, username: $username, createDt: $createDt, updateDt: $updateDt, name: $name, portrait: $portrait, state: $state, type: $type}';
  }
}
