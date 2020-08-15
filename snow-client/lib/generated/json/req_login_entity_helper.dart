import 'package:snowclient/data/entity/req_login_entity.dart';

reqLoginEntityFromJson(ReqLoginEntity data, Map<String, dynamic> json) {
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	return data;
}

Map<String, dynamic> reqLoginEntityToJson(ReqLoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['username'] = entity.username;
	data['password'] = entity.password;
	return data;
}