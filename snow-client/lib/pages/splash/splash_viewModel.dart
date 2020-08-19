import 'dart:async';

import 'package:snowclient/data/entity/login_user_info.dart';
import 'package:snowclient/data/model/login_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/pages/login/login_view_model.dart';

class SplashViewModel {
  StreamController<LoginStatus> _cacheLoginController;
  Stream<LoginStatus> getLoginUserInfoStream() {
    _cacheLoginController = StreamController<LoginStatus>();
    return _cacheLoginController.stream;
  }

  Future loginByCache() async {
    LoginModel loginModel = ModelManager.getInstance().getModel<LoginModel>();
    LoginUserInfo userInfo = await loginModel.loginByCache();
    if (userInfo == null) {
      _cacheLoginController.sink.add(LoginStatus.LOGIN_FAILED);
    } else {
      _cacheLoginController.sink.add(LoginStatus.LOGIN_SUCCESS);
    }
  }

  void close() {
    _cacheLoginController.close();
  }
}
