import 'package:imlib/imlib.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snowclient/data/db/dao/dao_manager.dart';
import 'package:snowclient/data/entity/login_user_info.dart';
import 'package:snowclient/data/entity/rsp_login_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/snow_model.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/service/login_service.dart';
import 'package:snowclient/uitls/CommonUtils.dart';
import 'package:snowclient/uitls/Constans.dart';

import 'model_manager.dart';

class LoginModel extends SnowModel {
  //账号密码登录
  Future<LoginUserInfo> loginByPassWord(String userName, String password) async {
    RspLoginEntity rspLoginEntity = await HttpManager.getInstance().getService<LoginService>().login(userName, password);
    String currentUid = rspLoginEntity.uid;
    String token = rspLoginEntity.token;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (token != null && token.isNotEmpty && currentUid != null && currentUid.isNotEmpty) {
      preferences.setString(Constants.PREFERENCE_TOKEN, token);
      preferences.setString(Constants.PREFERENCE_LOGIN_UID, currentUid);
      preferences.setString(Constants.PREFERENCE_LOGIN_TIME, CommonUtils.currentTime().toString());
      await _initApp(currentUid,token);
      return LoginUserInfo(currentUid, token);
    } else {
      return null;
    }
  }

  //缓存登录相关逻辑
  Future<LoginUserInfo> loginByCache() async {
    print("SplashPage loginByCache");
    await HttpManager.getInstance().init();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get(Constants.PREFERENCE_TOKEN);
    String currentUid = preferences.get(Constants.PREFERENCE_LOGIN_UID);
    String lastLoginTime = preferences.get(Constants.PREFERENCE_LOGIN_TIME);
    if (token == null || lastLoginTime == null || CommonUtils.currentTime() - int.parse(lastLoginTime) > Constants.TOKEN_VALID_TIME) {
      return null;
    } else {
      await _initApp(currentUid, token);
      return LoginUserInfo(currentUid, token);
    }
  }

  Future _initApp(String uid, String token) async {
    SnowIMClient.getInstance().getController().stream.listen((event) {
      print("connect changed event:$event");
    });
    SnowIMClient.getInstance().connect(token);
    await DaoManager.getInstance().init(uid);
    ModelManager.getInstance().init();
    await ModelManager.getInstance().getModel<ContactModel>().syncUserData();
  }
}
