import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/contacts/profile/contact_profile_view_model.dart';

class ContactProfilePage extends StatelessWidget {
  final String uid;

  ContactProfilePage(this.uid);

  @override
  Widget build(BuildContext context) {
    SLog.i("uid = $uid");
    return StreamProvider.controller(
      create: (_) => ContactProfileViewModel().getUserEntityStream(uid),
      child: ContactProfileStatefulPage(),
    );
  }
}

class ContactProfileStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactProfileState();
  }
}

class ContactProfileState extends State<ContactProfileStatefulPage> {
  UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    userEntity = Provider.of<UserEntity>(context);
    SLog.i("ContactProfileStatefulPage build userEntity = $userEntity");
    String name = userEntity == null ? "" : userEntity.name;
    String phone = userEntity == null ? "" : userEntity.username;
    String uid = userEntity == null ? "" : userEntity.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).contactProfile),
      ),
      body: Column(
        children: [
          _buildHeader(name),
          Divider(
            thickness: 10,
            height: 10,
            color: Colors.grey,
          ),
          _buildItem(phone),
          Divider(
            thickness: 10,
            height: 10,
            color: Colors.grey,
          ),
          Expanded(
            child: _buildPanel(uid),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Icon(Icons.account_box),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 40.0),
                  ),
                  Text("地区: 中国")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(String phone) {
    return Container(
      color: Colors.white,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.phone),
          ),
          Text(
            phone,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ],
      ),
    );
  }

  Widget _buildPanel(String uid) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _onStartMessagePageClick(uid),
            child: Container(
              width: 300,
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).contactProfileSendMessage,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onStartMessagePageClick(String uid) {
    SLog.i("_onStartMessagePageClick() $uid");
  }
}
