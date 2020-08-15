import 'package:snowclient/data/entity/rsp_login_entity.dart';

rspLoginEntityFromJson(RspLoginEntity data, Map<String, dynamic> json) {
	if (json['appKey'] != null) {
		data.appKey = json['appKey']?.toString();
	}
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	return data;
}

Map<String, dynamic> rspLoginEntityToJson(RspLoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['appKey'] = entity.appKey;
	data['uid'] = entity.uid;
	data['token'] = entity.token;
	return data;
}