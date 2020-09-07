import 'package:snowclient/data/entity/req_login_entity.dart';
import 'package:snowclient/data/entity/req_register_entity.dart';
import 'package:snowclient/data/entity/rsp_login_entity.dart';
import 'package:snowclient/generated/json/req_register_entity_helper.dart';
import 'package:snowclient/rest/base_result.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/service/http_service.dart';

class LoginService extends HttpService {
  static const String LOGIN = "/auth/login";
  static const String CREATE_USER = "/user/create";

  LoginService(HttpHelper httpHelper) : super(httpHelper);

  Future<RspLoginEntity> login(String userName, String password) async {
    ReqLoginEntity reqLoginEntity = ReqLoginEntity();
    reqLoginEntity.username = userName;
    reqLoginEntity.password = password;
    BaseResult<RspLoginEntity> result = await httpHelper.post<RspLoginEntity>(LOGIN, null, reqLoginEntity.toJson());
    return result.data;
  }

  Future<BaseResult<String>> registerAccount(String username, String name, String password) async {
    ReqRegisterEntity registerEntity = ReqRegisterEntity();
    registerEntity.password = password;
    registerEntity.username = username;
    registerEntity.name = name;
    registerEntity.type = 2;
    return httpHelper.put(CREATE_USER, null, registerEntity.toJson());
  }
}
