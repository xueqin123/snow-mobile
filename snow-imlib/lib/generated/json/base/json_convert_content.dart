// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/generated/json/group_entity_helper.dart';
import 'package:imlib/data/db/entity/req_group_entity.dart';
import 'package:imlib/generated/json/req_group_entity_helper.dart';
import 'package:imlib/data/db/entity/host_entity.dart';
import 'package:imlib/generated/json/host_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case GroupEntity:
			return groupEntityFromJson(data as GroupEntity, json) as T;			case GroupDetail:
			return groupDetailFromJson(data as GroupDetail, json) as T;			case ReqGroupEntity:
			return reqGroupEntityFromJson(data as ReqGroupEntity, json) as T;			case HostEntity:
			return hostEntityFromJson(data as HostEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case GroupEntity:
			return groupEntityToJson(data as GroupEntity);			case GroupDetail:
			return groupDetailToJson(data as GroupDetail);			case ReqGroupEntity:
			return reqGroupEntityToJson(data as ReqGroupEntity);			case HostEntity:
			return hostEntityToJson(data as HostEntity);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'GroupEntity':
			return GroupEntity().fromJson(json);			case 'GroupDetail':
			return GroupDetail().fromJson(json);			case 'ReqGroupEntity':
			return ReqGroupEntity().fromJson(json);			case 'HostEntity':
			return HostEntity().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'GroupEntity':
			return List<GroupEntity>();			case 'GroupDetail':
			return List<GroupDetail>();			case 'ReqGroupEntity':
			return List<ReqGroupEntity>();			case 'HostEntity':
			return List<HostEntity>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}