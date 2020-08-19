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
        title: Text(viewModel.chatName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => _buildCustomMessageItemWidget(context, index),
            itemCount: viewModel.data.length,
          ),
          _buildInputWidget(),
        ],
      ),
    );
  }

  Widget _buildCustomMessageItemWidget(BuildContext context, int index) {
    SLog.i("data size:${viewModel.data.length}");
    String type = viewModel.data[index].type;
    CustomMessage customMessage = viewModel.data[index];
    MainAxisAlignment alignment = MainAxisAlignment.start;
    if (customMessage.direction == Direction.SEND) {
      alignment = MainAxisAlignment.end;
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: alignment, children: [MessageWidgetManager.getInstance().getMessageWidgetProvider(customMessage.type)(customMessage)]),
    );
  }

  Widget _buildInputWidget() {
    return Row(
      children: [
        Container(
          width: 300,
          height: 35,
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            controller: viewModel.sendTextController,
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => viewModel.sendTextMessage(),
            child: Container(
              height: 35,
              decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).messageSend,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
