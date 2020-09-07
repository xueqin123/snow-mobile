import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/rest/base_result.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/server_code.dart';
import 'package:snowclient/rest/service/login_service.dart';
import 'package:snowclient/uitls/common_utils.dart';

class RegisterViewModel with ChangeNotifier {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  StreamController<String> _toastController;

  TextEditingController get phoneController => _phoneController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController => _confirmPasswordController;

  TextEditingController get nameController => _nameController;
  RegisterStatus registerStatus = RegisterStatus.IDLE;

  Future<AccountInfo> registerAccount() async {
    String phoneNumber = _phoneController.text;
    String name = _nameController.text;
    String password = _passwordController.text;
    String confirmPassword = _passwordController.text;
    SLog.i("registerAccount() phoneNumber:$phoneNumber name:$name password:$password confirmPassword:$confirmPassword");
    if (!CommonUtils.isChinaPhoneLegal(phoneNumber)) {
      _toastController.sink.add(S.current.loginError);
      _setRegisterStatus(RegisterStatus.REGISTER_FAILED);
      return null;
    }

    if (name == null || name.isEmpty) {
      _toastController.sink.add(S.current.nickNameIllegal);
      _setRegisterStatus(RegisterStatus.REGISTER_FAILED);
      return null;
    }

    if ((password == null || password.isEmpty) && (confirmPassword == null || confirmPassword.isEmpty) && password != confirmPassword) {
      _toastController.sink.add(S.current.passwordIllegal);
      _setRegisterStatus(RegisterStatus.REGISTER_FAILED);
      return null;
    }
    _setRegisterStatus(RegisterStatus.REGISTERING);
    BaseResult<String> result = await HttpManager.getInstance().getService<LoginService>().registerAccount(phoneNumber, name, password);
    _toastController.sink.add(result.msg);
    bool isSuccess = result.code == ServerCode.SUCCESS;
    if (isSuccess) {
      _setRegisterStatus(RegisterStatus.REGISTER_SUCCESS);
    } else {
      _setRegisterStatus(RegisterStatus.REGISTER_FAILED);
    }
    if (isSuccess) {
      return AccountInfo(phoneNumber, password);
    }
    return null;
  }

  StreamController<String> getToastController() {
    _toastController = StreamController<String>();
    return _toastController;
  }

  _setRegisterStatus(RegisterStatus state) {
    registerStatus = state;
    notifyListeners();
  }
}

class AccountInfo {
  String phoneNumber;
  String password;

  AccountInfo(this.phoneNumber, this.password);
}

enum RegisterStatus { IDLE, REGISTERING, REGISTER_SUCCESS, REGISTER_FAILED }
