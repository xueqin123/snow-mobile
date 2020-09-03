import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/data/entity/req_user_entity.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/rest/base_result.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/server_code.dart';
import 'package:snowclient/rest/service/http_service.dart';

class UserService extends HttpService {
  static const String _CONTACT_LIST = "/user/list?type=2&state=0";
  static const String _CONTACT = "/user/";

  UserService(HttpHelper httpHelper) : super(httpHelper);

  Future<List<UserEntity>> getAllUserList() async {
    Map<String, dynamic> param = Map();
    param["type"] = 2;
    param["state"] = 0;
    BaseResult<List<UserEntity>> result = await httpHelper.get<List<UserEntity>>(_CONTACT_LIST, param, null);
    return result.data;
  }

  Future<UserEntity> getUserByUid(String uid) async {
    BaseResult<UserEntity> result = await httpHelper.get<UserEntity>(_CONTACT + uid, null, null);
    return result.data;
  }

  Future<bool> updateUserByUid(String uid, ReqUserEntity reqUserEntity) async {
    BaseResult result = await httpHelper.post(_CONTACT + uid, null, reqUserEntity.toJson());
    return result.code == ServerCode.SUCCESS;
  }
}
