import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/pages/contacts/profile/contact_profile_page.dart';
import 'package:snowclient/uitls/widge/widget_utils.dart';

import 'contact_view_model.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SLog.i("ContactPage build");
    ContactViewModel _contactViewModel = ContactViewModel();
    return MultiProvider(
      providers: [
        StreamProvider<List<UserEntity>>.controller(
          create: (_) => _contactViewModel.getAllUserController(),
          initialData: <UserEntity>[],
        ),
        ChangeNotifierProvider(
          create: (_) => _contactViewModel,
        )
      ],
      child: ContactStatefulPage(),
    );
  }
}

class ContactStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactState();
  }
}

class ContactState extends State<ContactStatefulPage> {
  List<UserEntity> userList;

  @override
  Widget build(BuildContext context) {
    userList = Provider.of<List<UserEntity>>(context);
    SLog.i("ContactState build user size: ${userList.length}");
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: userList.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onItemClick(index),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: WidgetUtils.buildNetImage(userList[index].portrait),
            ),
            Expanded(
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(userList[index].name),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  void _onItemClick(int index) {
    SLog.i("onClick index = $index");
    String uid = userList[index].uid;
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactProfilePage(uid)));
  }
}
