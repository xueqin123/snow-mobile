import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/login/register/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = RegisterViewModel();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => viewModel), StreamProvider.controller(create: (_) => viewModel.getToastController())],
      child: RegisterStatefulPage(),
    );
  }
}

class RegisterStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterStatefulPage> {
  FocusNode _nameNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmFocusNode = FocusNode();
  RegisterViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<RegisterViewModel>(context);
    String toastMsg = Provider.of<String>(context);
    if (toastMsg != null && toastMsg.isNotEmpty) {
      Fluttertoast.showToast(msg: toastMsg);
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/launch_image.jpeg"), fit: BoxFit.cover),
        ),
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
                    FocusScope.of(context).requestFocus(_nameNode);
                  },
                  keyboardType: TextInputType.number,
                  controller: _viewModel.phoneController,
                  decoration: InputDecoration(icon: Icon(Icons.person), labelText: S.of(context).loginPhoneNumber, border: OutlineInputBorder()),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
                TextField(
                  focusNode: _nameNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  controller: _viewModel.nameController,
                  decoration: InputDecoration(icon: Icon(Icons.ac_unit), labelText: S.of(context).nickName, border: OutlineInputBorder()),
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_confirmFocusNode);
                  },
                  keyboardType: TextInputType.visiblePassword,
                  controller: _viewModel.passwordController,
                  decoration: InputDecoration(icon: Icon(Icons.lock), labelText: S.of(context).loginPassword, border: OutlineInputBorder()),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
                TextField(
                    focusNode: _confirmFocusNode,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _viewModel.confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                      labelText: S.of(context).confirmPassword,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                buildLoginButton(),
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
          visible: _viewModel.registerStatus == RegisterStatus.REGISTER_FAILED || _viewModel.registerStatus == RegisterStatus.IDLE,
          child: Center(
            child: SizedBox(
              width: 160,
              child: RaisedButton(
                onPressed: () {
                  _confirmFocusNode.unfocus();
                  _registerAccount();
                },
                child: Text(
                  S.of(context).registerAccount,
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _viewModel.registerStatus == RegisterStatus.REGISTERING,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
        Visibility(
          visible: _viewModel.registerStatus == RegisterStatus.REGISTER_SUCCESS,
          child: Icon(Icons.check),
        )
      ],
    );
  }

  _registerAccount() async {
    AccountInfo accountInfo = await _viewModel.registerAccount();
    if (accountInfo != null) {
      Navigator.pop<AccountInfo>(context, accountInfo);
    }
  }
}
