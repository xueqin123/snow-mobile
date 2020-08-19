import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:provider/provider.dart';
import 'chat_view_model.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SLog.i("ChatPage build");
    ChatViewModel _chatViewModel = ChatViewModel();
    return MultiProvider(
      providers: [
        StreamProvider<List<ConversationEntity>>.controller(
          create: (_) => _chatViewModel.getAllConversationStream(),
          initialData: <ConversationEntity>[],
        ),
        ChangeNotifierProvider(
          create: (_) => _chatViewModel,
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
  List<ConversationEntity> conversationList;

  @override
  Widget build(BuildContext context) {
    conversationList = Provider.of<List<ConversationEntity>>(context);
    SLog.i("ChatState build chat size: ${conversationList.length}");
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: conversationList.length,
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
              child: Icon(Icons.account_box),
            ),
            Expanded(
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(conversationList[index].conversationId),
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
    String conversationId = conversationList[index].conversationId;
  }
}
