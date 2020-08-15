import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/pages/chat/chat_page.dart';
import 'package:snowclient/pages/contacts/contact_page.dart';
import 'package:snowclient/pages/discover/discover_page.dart';
import 'package:snowclient/pages/home/home_view_model.dart';
import 'package:snowclient/pages/mine/mine_page.dart';
import 'package:snowclient/uitls/widge/badge_widget.dart';
import '../../generated/l10n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("HomePage build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
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
        child: TabBar(
            controller: _tabController,
            indicator: const BoxDecoration(),
            tabs: [_buildTab(Icons.chat, S.of(context).pageHomeTabMessage), _buildTab(Icons.contacts, S.of(context).pageHomeTabContact), _buildTab(Icons.cloud_circle, S.of(context).pageHomeTabDiscover), _buildTab(Icons.trip_origin, S.of(context).pageHomeTabMine)]),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.star),
        onPressed: () {
          _testClick();
        },
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

  Tab _buildTab(IconData iconData, String name) {
    return Tab(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
          ),
          BadgeWidget(
            _badgeCount,
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
    print("onSearch click");
  }

  void _onMoreSelect(int index) {
    switch (index) {
      case 0:
        print("发起群聊 click");
        break;
      case 1:
        print("添加好友 click");
        break;
      default:
        break;
    }
  }

  void _testClick() {
    _upDateBadge();
  }
}
