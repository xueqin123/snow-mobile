import 'package:snowclient/data/entity/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['create_dt'] != null) {
		data.createDt = json['create_dt']?.toString();
	}
	if (json['update_dt'] != null) {
		data.updateDt = json['update_dt']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['portrait'] != null) {
		data.portrait = json['portrait']?.toString();
	}
	if (json['state'] != null) {
		data.state = json['state']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['username'] = entity.username;
	data['create_dt'] = entity.createDt;
	data['update_dt'] = entity.updateDt;
	data['name'] = entity.name;
	data['portrait'] = entity.portrait;
	data['state'] = entity.state;
	data['type'] = entity.type;
	return data;
}