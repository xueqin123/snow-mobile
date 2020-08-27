import 'package:imlib/data/db/entity/group_entity.dart';

groupEntityFromJson(GroupEntity data, Map<String, dynamic> json) {
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toString();
	}
	if (json['conversationId'] != null) {
		data.conversationId = json['conversationId']?.toString();
	}
	if (json['detail'] != null) {
		data.detail = new GroupDetail().fromJson(json['detail']);
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	return data;
}

Map<String, dynamic> groupEntityToJson(GroupEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['groupId'] = entity.groupId;
	data['conversationId'] = entity.conversationId;
	if (entity.detail != null) {
		data['detail'] = entity.detail.toJson();
	}
	data['time'] = entity.time;
	return data;
}

groupDetailFromJson(GroupDetail data, Map<String, dynamic> json) {
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['portrait'] != null) {
		data.portrait = json['portrait']?.toString();
	}
	if (json['member'] != null) {
		data.member = json['member']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> groupDetailToJson(GroupDetail entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['portrait'] = entity.portrait;
	data['member'] = entity.member;
	return data;
}