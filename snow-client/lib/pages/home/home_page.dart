import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imlib/imlib.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/model/homeModel.dart';
import 'package:snowclient/pages/chat/chat_page.dart';
import 'package:snowclient/pages/contacts/contact_page.dart';
import 'package:snowclient/pages/contacts/select/contatc_select_page.dart';
import 'package:snowclient/pages/discover/discover_page.dart';
import 'package:snowclient/pages/home/home_view_model.dart';
import 'package:snowclient/pages/mine/mine_page.dart';
import 'package:snowclient/uitls/widge/badge_widget.dart';
import '../../generated/l10n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SLog.i("HomePage build");
    HomeViewModel homeViewModel = HomeViewModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => homeViewModel,
        ),
        StreamProvider.controller(
          create: (_) => homeViewModel.getTotalUnReadCountController(),
          initialData: UnreadCount(),
        )
      ],
      child: HomeStatefulPage(),
    );
  }
}

class HomeStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStatefulPageState();
}

class _HomeStatefulPageState extends State<HomeStatefulPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _badgeCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    UnreadCount unreadCount = Provider.of<UnreadCount>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearchClick,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          PopupMenuButton(
            icon: Icon(Icons.add_circle_outline),
            offset: Offset(0, 40),
            color: Colors.brown,
            itemBuilder: (BuildContext context) {
              return [_buildPopMenuItem(Icons.chat_bubble, S.of(context).pageMessagePopStartChat, 0), _buildPopMenuItem(Icons.group_add, S.of(context).pageMessagePopAddFriend, 1)];
            },
            onSelected: _onMoreSelect,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ChatPage(), ContactPage(), DisCoverPage(), MinePage()],
      ),
      bottomNavigationBar: Material(
        color: Colors.brown,
        child: TabBar(controller: _tabController, indicator: const BoxDecoration(), tabs: [
          _buildTab(Icons.chat, S.of(context).pageHomeTabMessage, unreadCount.MessageUnReadCount),
          _buildTab(Icons.contacts, S.of(context).pageHomeTabContact, unreadCount.ContactUnReadCount),
          _buildTab(Icons.cloud_circle, S.of(context).pageHomeTabDiscover, unreadCount.discoveryUnReadCount),
          _buildTab(Icons.trip_origin, S.of(context).pageHomeTabMine, unreadCount.mineUnReadCount)
        ]),
      ),
    );
  }

  void _upDateBadge() {
    setState(() {
      _badgeCount++;
    });
  }

  PopupMenuItem<int> _buildPopMenuItem(IconData iconData, String title, int index) {
    return PopupMenuItem(
        value: index,
        child: Container(
          child: Row(
            children: [
              Icon(iconData),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }

  Tab _buildTab(IconData iconData, String name, int unReadCount) {
    return Tab(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
          ),
          BadgeWidget(
            unReadCount,
            anchor: Icon(iconData),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  void _onSearchClick() {
    SLog.i("onSearch click");
  }

  void _onMoreSelect(int index) {
    switch (index) {
      case 0:
        SLog.i("发起群聊 click");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSelectPage()));
        break;
      case 1:
        Fluttertoast.showToast(msg: "todo",textColor: Colors.red);
        break;
      default:
        break;
    }
  }
}
