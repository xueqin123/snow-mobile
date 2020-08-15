import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/home/home_page.dart';
import 'package:snowclient/pages/login/login_view_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("LoginPage build()");
    LoginViewModel _loginViewModel = LoginViewModel();
    _loginViewModel.getLoginUserInfoStream().listen((event) {
      _toHomePage(context);
    });
    _loginViewModel.getToastStream().listen((event) {
      Fluttertoast.showToast(msg: event);
    });
    return ChangeNotifierProvider(
      create: (_) => _loginViewModel,
      child: LoginStatefulPage(),
    );
  }

  void _toHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => new HomePage()), (route) => route == null);
  }
}

class LoginStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginStatefulPage> with WidgetsBindingObserver {
  FocusNode _passwordFocusNode = FocusNode();
  LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    print("initState");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState state");
  }

  @override
  void dispose() {
    print("dispose");
    _loginViewModel.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("LoginState build()");
    _loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: 300,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  keyboardType: TextInputType.number,
                  controller: _loginViewModel.phoneController,
                  decoration: InputDecoration(icon: Icon(Icons.person), labelText: S.of(context).loginPhoneNumber, border: OutlineInputBorder()),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
                TextField(
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _loginViewModel.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                      labelText: S.of(context).loginPassword,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                buildLoginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Stack(
      children: [
        Visibility(
          visible: _loginViewModel.loginStatus == LoginStatus.LOGIN_FAILED || _loginViewModel.loginStatus == LoginStatus.IDLE,
          child: Center(
            child: SizedBox(
              width: 160,
              child: RaisedButton(
                onPressed: () {
                  _passwordFocusNode.unfocus();
                  _loginViewModel.loginByPassWord();
                },
                child: Text(
                  S.of(context).loginButton,
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _loginViewModel.loginStatus == LoginStatus.LOGGING,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
        Visibility(
          visible: _loginViewModel.loginStatus == LoginStatus.LOGIN_SUCCESS,
          child: Icon(Icons.check),
        )
      ],
    );
  }
}
