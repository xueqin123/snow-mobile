import 'package:imlib/data/db/entity/req_group_entity.dart';

reqGroupEntityFromJson(ReqGroupEntity data, Map<String, dynamic> json) {
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['portrait'] != null) {
		data.portrait = json['portrait']?.toString();
	}
	if (json['members'] != null) {
		data.members = json['members']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> reqGroupEntityToJson(ReqGroupEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['portrait'] = entity.portrait;
	data['members'] = entity.members;
	return data;
}