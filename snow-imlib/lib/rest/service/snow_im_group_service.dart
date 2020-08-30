import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/data/db/entity/req_group_entity.dart';
import 'package:imlib/rest/service/snow_im_http_service.dart';
import 'package:imlib/rest/snow_im_http_helper.dart';

class SnowIMGroupService extends SnowIMHttpService {
  SnowIMGroupService(SnowIMHttpHelper httpHelper) : super(httpHelper);
  static const String _GROUP_CREATE = "/admin/group/create";
  static const String _GROUP_DETAIL = "/admin/group/";

  Future<GroupEntity> createGroup(String name, String portrait, List<String> memberIds) async {
    ReqGroupEntity reqGroupEntity = ReqGroupEntity();
    reqGroupEntity.name = name;
    reqGroupEntity.portrait = portrait;
    reqGroupEntity.members = memberIds;
    return httpHelper.post<GroupEntity>(_GROUP_CREATE, null, reqGroupEntity.toJson());
  }

  Future<GroupEntity> getGroupDetail(String groupId) {
    return httpHelper.get<GroupEntity>(_GROUP_DETAIL + groupId, null, null);
  }
}
