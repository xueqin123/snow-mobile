import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/pages/message/message_page.dart';
import 'package:snowclient/uitls/common_utils.dart';
import 'package:snowclient/uitls/const_router.dart';
import 'package:snowclient/uitls/widge/badge_widget.dart';
import 'package:snowclient/uitls/widge/widget_utils.dart';
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
    SLog.i("ChatState build chat data: ${data.length}");
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
              child: BadgeWidget(data[index].unReadCount, anchor: WidgetUtils.buildNetImage(data[index].portrait)),
            ),
            Expanded(
              child: Stack(children: [
                Column(
                  children: [
                    Container(
                      height: 30,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(data[index].chatName),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(CommonUtils.dateFormat(data[index].lastTime)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.topLeft,
                      child: _buildContent(data[index]),
                    ))
                  ],
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

  _buildContent(ChatItemEntity chatItemEntity) {
    return Text("${chatItemEntity.lastName}: ${chatItemEntity.lastContent}");
  }

  void _onItemClick(int index) {
    SLog.i("onClick index = $index");
    ChatItemEntity itemEntity = data[index];
    Map<String, Object> arg = Map();
    arg[MessagePage.TARGET_ID] = itemEntity.targetId;
    arg[MessagePage.CONVERSATION_TYPE] = itemEntity.chatType;
    Navigator.pushNamed(context, ConstRouter.MESSAGE_PAGE, arguments: arg);
  }
}
