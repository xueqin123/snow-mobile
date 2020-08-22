import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/pages/message/message_page.dart';
import 'chat_item_entity.dart';
import 'chat_view_model.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SLog.i("ChatPage build");
    ChatViewModel _chatViewModel = ChatViewModel();
    return MultiProvider(
      providers: [
        StreamProvider<List<ChatItemEntity>>.controller(
          create: (_) => _chatViewModel.getChatListController(),
          initialData: [],
        )
      ],
      child: ChatStatefulPage(),
    );
  }
}

class ChatStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatState();
  }
}

class ChatState extends State<ChatStatefulPage> {
  List<ChatItemEntity> data;

  @override
  Widget build(BuildContext context) {
    data = Provider.of<List<ChatItemEntity>>(context);
    SLog.i("ChatState build chat data: $data");
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: data.length,
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
              child: Icon(Icons.chat),
            ),
            Expanded(
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(data[index].chatName),
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
    ChatItemEntity itemEntity = data[index];
    Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage(itemEntity.targetId,itemEntity.chatType)));
  }
}
