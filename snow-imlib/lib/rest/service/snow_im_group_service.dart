import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/data/db/entity/req_group_entity.dart';
import 'package:imlib/rest/base_result.dart';
import 'package:imlib/rest/service/snow_im_http_service.dart';
import 'package:imlib/rest/snow_im_http_helper.dart';
import 'package:imlib/utils/snow_im_const.dart';

class SnowIMGroupService extends SnowIMHttpService {
  SnowIMGroupService(SnowIMHttpHelper httpHelper) : super(httpHelper);
  static const String _GROUP_CREATE = "/admin/group/create";
  static const String _GROUP_DETAIL = "/admin/group/";
  static const String _GROUP_DELETE = "/admin/group/";

  Future<GroupEntity> createGroup(String name, String portrait, List<String> memberIds) async {
    ReqGroupEntity reqGroupEntity = ReqGroupEntity();
    reqGroupEntity.name = name;
    reqGroupEntity.portrait = portrait;
    reqGroupEntity.members = memberIds;
    BaseResult baseResult = await httpHelper.post<GroupEntity>(_GROUP_CREATE, null, reqGroupEntity.toJson());
    return baseResult.data;
  }

  Future<bool> dismissGroup(String groupId) async {
    BaseResult baseResult = await httpHelper.del(_GROUP_DELETE + groupId, null, null);
    if (baseResult.code == SnowIMConst.REQUEST_SUCCESS) {
      return true;
    } else {
      return false;
    }
  }

  Future<GroupEntity> getGroupDetail(String groupId) async {
    BaseResult<GroupEntity> baseResult = await httpHelper.get<GroupEntity>(_GROUP_DETAIL + groupId, null, null);
    return baseResult.data;
  }
}
