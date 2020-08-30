import 'package:imlib/data/db/entity/host_entity.dart';

hostEntityFromJson(HostEntity data, Map<String, dynamic> json) {
	if (json['ip'] != null) {
		data.ip = json['ip']?.toString();
	}
	if (json['port'] != null) {
		data.port = json['port']?.toInt();
	}
	return data;
}

Map<String, dynamic> hostEntityToJson(HostEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ip'] = entity.ip;
	data['port'] = entity.port;
	return data;
}