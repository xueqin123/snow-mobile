import 'package:snowclient/data/entity/group_entity.dart';
import 'package:snowclient/data/entity/group_member_entity.dart';
import 'package:snowclient/data/entity/req_group_entity.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/service/service.dart';

class GroupService extends HttpService {
  static const String _CREATE_GROUP = "/group/create";
  static const String _JOIN_GROUP = "/group/join";
  static const String _KICK_GROUP = "/group/kick";
  static const String _QUIT_GROUP = "/group/quit";
  static const String _DISMISS_GROUP = "/group/dismiss";
  static const String _DETAIL_GROUP = "/group/detail";
  static const String _DETAILS_GROUP = "/group/details";
  static const String _DETAILS_GROUP_MEMBER_LIST = "/group/memberlist";

  GroupService(HttpHelper httpHelper) : super(httpHelper);

  Future<GroupEntity> createGroup(String groupName, String portrait, List<String> memberIds) {
    ReqGroupEntity reqGroupEntity = ReqGroupEntity();
    reqGroupEntity.name = groupName;
    reqGroupEntity.members = memberIds;
    reqGroupEntity.portrait = portrait;
    return httpHelper.post(_CREATE_GROUP, null, reqGroupEntity.toJson());
  }

  Future<List<GroupMemberEntity>> getGroupMemberList(String groupId) {
    Map<String, dynamic> param = Map();
    param["id"] = groupId;
    return httpHelper.get(_DETAILS_GROUP_MEMBER_LIST, param, null);
  }
}
