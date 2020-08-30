import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/pages/mine/mine_view_model.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.controller(
      create: (_) => MineViewModel().getMineEntityStream(),
      child: MineStatefulPage(),
    );
  }
}

class MineStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MineState();
  }
}

class MineState extends State<MineStatefulPage> {
  UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    userEntity = Provider.of<UserEntity>(context);
    SLog.i("MinePage build userEntity = $userEntity");
    String name = userEntity == null ? "" : userEntity.name;
    String phone = userEntity == null ? "" : userEntity.username;
    String uid = userEntity == null ? "" : userEntity.uid;
    return Column(
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
      ],
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
}
