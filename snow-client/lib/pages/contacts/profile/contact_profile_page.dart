import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/contacts/profile/contact_profile_view_model.dart';
import 'package:snowclient/pages/message/message_page.dart';
import 'package:snowclient/uitls/const_router.dart';
import 'package:snowclient/uitls/widge/portrait_widget.dart';

class ContactProfilePage extends StatelessWidget {
  final String uid;

  ContactProfilePage(this.uid);

  ContactProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = ContactProfileViewModel();
    SLog.i("uid = $uid");
    return MultiProvider(
      providers: [
        StreamProvider.controller(
          create: (_) => viewModel.getUserEntityStream(uid),
        ),
        ChangeNotifierProvider(create: (_) => viewModel),
      ],
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
  ContactProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ContactProfileViewModel>(context);
    userEntity = Provider.of<UserEntity>(context);
    SLog.i("ContactProfileStatefulPage build userEntity = $userEntity");
    String name = userEntity == null ? "" : userEntity.name;
    String phone = userEntity == null ? "" : userEntity.username;
    String uid = userEntity == null ? "" : userEntity.uid;
    String portraitUrl = userEntity == null ? "" : userEntity.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).contactProfile),
      ),
      body: Column(
        children: [
          _buildHeader(name, portraitUrl),
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

  Widget _buildHeader(String name, String portraitUrl) {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            child: Align(
              alignment: Alignment.center,
              child: PortraitWidget(portraitUrl,60),
            ),
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
          Visibility(
            visible: uid != viewModel.selfUid,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }

  void _onStartMessagePageClick(String uid) {
    Map map = Map();
    map[MessagePage.TARGET_ID] = uid;
    map[MessagePage.CONVERSATION_TYPE] = ConversationType.SINGLE;
    Navigator.popAndPushNamed(context, ConstRouter.MESSAGE_PAGE, arguments: map);
  }
}
