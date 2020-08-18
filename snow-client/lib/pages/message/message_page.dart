import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';

import 'message_view_model.dart';
import 'message_widet_manager.dart';

class MessagePage extends StatelessWidget {
  String targetId;
  ChatType chatType;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageViewModel(targetId, chatType)),
      ],
      child: MessageStatefulWidget(),
    );
  }

  MessagePage(this.targetId, this.chatType);
}

class MessageStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageState();
  }
}

class MessageState extends State<MessageStatefulWidget> {
  MessageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<MessageViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _buildCustomMessageItemWidget(context, index),
        itemCount: viewModel.data.length,
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            width: 300,
            child: TextField(
              controller: viewModel.sendTextController,
            ),
          ),
          Expanded(
            child: RaisedButton(
              child: Text(S.of(context).messageSend),
              onPressed: viewModel.sendTextMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMessageItemWidget(BuildContext context, int index) {
    SLog.i("data size:${viewModel.data.length}");
    String type = viewModel.data[index].type;
    return MessageWidgetManager.getInstance().getMessageWidgetProvider(type)(viewModel.data[index]);
  }
}
