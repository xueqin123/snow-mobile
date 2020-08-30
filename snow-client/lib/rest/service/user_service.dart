import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/service/http_service.dart';

class UserService extends HttpService {
  static const String _CONTACT_LIST = "/user/list?type=2&state=0";
  static const String _CONTACT = "/user/";

  UserService(HttpHelper httpHelper) : super(httpHelper);


  Future<List<UserEntity>> getAllUserList() async {
    Map<String, dynamic> param = Map();
    param["type"] = 2;
    param["state"] = 0;
    List<UserEntity> userList = await httpHelper.get<List<UserEntity>>(_CONTACT_LIST, param, null);
    return userList;
  }

  Future<UserEntity> getUserByUid(String uid) async {
    return httpHelper.get<UserEntity>(_CONTACT + uid, null, null);
  }
}
