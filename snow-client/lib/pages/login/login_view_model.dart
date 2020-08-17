import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:imlib/imlib.dart';
import 'package:snowclient/data/entity/login_user_info.dart';
import 'package:snowclient/data/model/login_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/base_view_model.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/uitls/CommonUtils.dart';

class LoginViewModel extends BaseViewModel with ChangeNotifier {
  LoginStatus _loginStatus = LoginStatus.IDLE;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  StreamController<LoginUserInfo> _loginController;
  StreamController<String> _toastController;

  get loginStatus => _loginStatus;

  get phoneController => _phoneController;

  get passwordController => _passwordController;

  Stream<LoginUserInfo> getLoginUserInfoStream() {
    _loginController = StreamController<LoginUserInfo>();
    return _loginController.stream;
  }

  Stream<String> getToastStream() {
    _toastController = StreamController<String>();
    return _toastController.stream;
  }

  //账号密码登录
  void loginByPassWord() async {
    SLog.i("login()");
    _updateLoginStatus(LoginStatus.LOGGING);
    String phoneNumber = _phoneController.text;
    String password = _passwordController.text;
    SLog.i("phoneNumber: $phoneNumber password: $password");
    if (!CommonUtils.isChinaPhoneLegal(phoneNumber) || password == null || password.isEmpty) {
      _updateLoginStatus(LoginStatus.LOGIN_FAILED);
      _toastController.sink.add(S.current.loginError);
      return;
    }
    LoginModel loginModel = ModelManager.getInstance().getModel<LoginModel>();
    LoginUserInfo loginUserInfo = await loginModel.loginByPassWord(phoneNumber, password);
    if (loginUserInfo == null) {
      _updateLoginStatus(LoginStatus.LOGIN_FAILED);
      _toastController.sink.add(S.current.loginHttpError);
    } else {
      _updateLoginStatus(LoginStatus.LOGIN_SUCCESS);
      _loginSuccess(loginUserInfo);
    }
  }

  void _loginSuccess(LoginUserInfo loginUserInfo) {
    _toastController.sink.add(S.current.loginSuccess);
    _loginController.sink.add(loginUserInfo);
  }

  void _updateLoginStatus(LoginStatus state) {
    _loginStatus = state;
    SLog.i("_updateLoginStatus() _loginStatus: $_loginStatus");
    notifyListeners();
  }

  @override
  void close() {
      _loginController.close();
      _toastController.close();
  }
}

enum LoginStatus {
  IDLE,
  LOGGING, //登录中
  LOGIN_SUCCESS, //登录成功
  LOGIN_FAILED
}
