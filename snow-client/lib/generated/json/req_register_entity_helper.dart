import 'package:snowclient/data/entity/req_register_entity.dart';

reqRegisterEntityFromJson(ReqRegisterEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['portrait'] != null) {
		data.portrait = json['portrait']?.toString();
	}
	return data;
}

Map<String, dynamic> reqRegisterEntityToJson(ReqRegisterEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['username'] = entity.username;
	data['type'] = entity.type;
	data['password'] = entity.password;
	data['portrait'] = entity.portrait;
	return data;
}