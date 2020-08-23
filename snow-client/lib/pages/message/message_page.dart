import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';

import 'message_view_model.dart';
import 'message_widet_manager.dart';

class MessagePage extends StatelessWidget {
  String targetId;
  ConversationType conversationType;
  MessageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    SLog.i("MessagePage build");
    viewModel = MessageViewModel(targetId, conversationType);
    return MultiProvider(
      providers: [
        StreamProvider.controller(
          create: (_) => viewModel.getMessageController(targetId, conversationType),
          initialData: <CustomMessage>[],
        ),
        ChangeNotifierProvider(create: (_) => viewModel),
      ],
      child: MessageStatefulWidget(),
    );
  }

  MessagePage(this.targetId, this.conversationType);
}

class MessageStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageState();
  }
}

class MessageState extends State<MessageStatefulWidget> {
  List<CustomMessage> data;
  MessageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<MessageViewModel>(context);
    data = Provider.of<List<CustomMessage>>(context);
    SLog.i("MessageState data.length: ${data.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text("todo name"),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => _buildCustomMessageItemWidget(context, index),
            itemCount: data.length,
          )),
          _buildInputWidget(),
        ],
      ),
    );
  }

  Widget _buildCustomMessageItemWidget(BuildContext context, int index) {
    SLog.i("data size:${data.length}");
    String type = data[index].type;
    CustomMessage customMessage = data[index];
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
