import 'package:snowclient/data/entity/rsp_credential_entity.dart';

rspCredentialEntityFromJson(RspCredentialEntity data, Map<String, dynamic> json) {
	if (json['tmpSecretId'] != null) {
		data.tmpSecretId = json['tmpSecretId']?.toString();
	}
	if (json['tmpSecretKey'] != null) {
		data.tmpSecretKey = json['tmpSecretKey']?.toString();
	}
	if (json['sessionToken'] != null) {
		data.sessionToken = json['sessionToken']?.toString();
	}
	return data;
}

Map<String, dynamic> rspCredentialEntityToJson(RspCredentialEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['tmpSecretId'] = entity.tmpSecretId;
	data['tmpSecretKey'] = entity.tmpSecretKey;
	data['sessionToken'] = entity.sessionToken;
	return data;
}