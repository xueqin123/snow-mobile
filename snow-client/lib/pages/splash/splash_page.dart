import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/pages/home/home_page.dart';
import 'package:snowclient/pages/login/login_page.dart';
import 'package:snowclient/pages/login/login_view_model.dart';
import 'package:snowclient/pages/splash/splash_viewModel.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/uitls/common_utils.dart';
import 'package:snowclient/uitls/constans.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SplashViewModel splashViewModel = SplashViewModel();
    splashViewModel.loginByCache();
    splashViewModel.getLoginUserInfoStream().listen((event) {
      _toPage(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  _buildContent() {
    var content = Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("images/launch_image.jpeg"), fit: BoxFit.cover),
      ),
    );
    return content;
  }

  _toPage(LoginStatus event) async {
    await Future.delayed(Duration(seconds: 1)); //延迟解决闪一下黑屏的问题
    if (event == LoginStatus.LOGIN_FAILED) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => route == null);
    } else if (event == LoginStatus.LOGIN_SUCCESS) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => route == null);
    }
  }
}
