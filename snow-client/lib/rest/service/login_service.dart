import 'package:snowclient/data/entity/req_login_entity.dart';
import 'package:snowclient/data/entity/rsp_login_entity.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/service/http_service.dart';

class LoginService extends HttpService {
  static const String LOGIN = "/auth/login";

  LoginService(HttpHelper httpHelper) : super(httpHelper);

  Future<RspLoginEntity> login(String userName, String password) {
    ReqLoginEntity reqLoginEntity = ReqLoginEntity();
    reqLoginEntity.username = userName;
    reqLoginEntity.password = password;
    return httpHelper.post<RspLoginEntity>(LOGIN, null, reqLoginEntity.toJson());
  }
}
