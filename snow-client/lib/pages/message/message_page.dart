import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/pages/message/widget/message_input_widget.dart';
import 'package:snowclient/uitls/const_router.dart';

import 'message_view_model.dart';
import 'message_widet_manager.dart';

class MessagePage extends StatelessWidget {
  static const String TARGET_ID = "target_id";
  static const String CONVERSATION_TYPE = "conversation_type";

  String targetId;
  ConversationType conversationType;
  MessageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    targetId = args[TARGET_ID];
    conversationType = args[CONVERSATION_TYPE];
    viewModel = MessageViewModel(targetId, conversationType);
    SLog.i("MessagePage build targetId:$targetId conversationType:$conversationType");

    return MultiProvider(
      providers: [
        StreamProvider.controller(
          create: (_) => viewModel.getMessageController(targetId, conversationType),
          initialData: <CustomMessage>[],
        ),
        ChangeNotifierProvider(create: (_) => viewModel),
        FutureProvider(
          create: (_) => viewModel.getChatName(),
          initialData: "",
        )
      ],
      child: MessageStatefulWidget(targetId, conversationType),
    );
  }
}

class MessageStatefulWidget extends StatefulWidget {
  String targetId;
  ConversationType conversationType;

  MessageStatefulWidget(this.targetId, this.conversationType);

  @override
  State<StatefulWidget> createState() {
    return MessageState();
  }
}

class MessageState extends State<MessageStatefulWidget> {
  List<CustomMessage> data;
  MessageViewModel viewModel;
  String chatName;
  MessageInputWidget inputWidget;

  @override
  void initState() {
    super.initState();
    inputWidget = MessageInputWidget();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<MessageViewModel>(context);
    inputWidget.controller = viewModel.sendTextController;
    inputWidget.sendClick = viewModel.sendTextMessage;
    inputWidget.conversationId = viewModel.targetId;
    inputWidget.conversationType = viewModel.chatType;
    data = Provider.of<List<CustomMessage>>(context);
    chatName = Provider.of<String>(context);
    SLog.i("MessageState data.length: ${data.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(chatName),
        actions: [IconButton(icon: Icon(Icons.portrait), onPressed: () => _gotoChatDetailPage(widget.targetId, widget.conversationType))],
      ),
      body: Column(
        children: [
          Expanded(
            child: AbsorbPointer(
              absorbing: false,
              child:Listener(
                onPointerDown: (_)=>inputWidget.unFocusTextInput(),
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildCustomMessageItemWidget(context, index),
                  itemCount: data.length,
                ),
              ) ,
            ),
          ),
          inputWidget
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
      child: Row(mainAxisAlignment: alignment, children: [Visibility(visible: customMessage.status != SendStatus.SUCCESS, child: _buildSendDot(customMessage.status)), MessageWidgetManager.getInstance().getMessageWidgetProvider(customMessage.type)(customMessage)]),
    );
  }

  Widget _buildSendDot(SendStatus status) {
    switch (status) {
      case SendStatus.FAILED:
        return Icon(Icons.warning);
        break;
      case SendStatus.SENDING:
      case SendStatus.PERSIST:
        return Icon(Icons.adjust);
        break;
      case SendStatus.SUCCESS:
        return Icon(Icons.check);
        break;
      default:
        return Icon(Icons.check);
        break;
    }
  }

  _gotoChatDetailPage(String targetId, ConversationType conversationType) {
    Map map = Map();
    map[MessagePage.TARGET_ID] = targetId;
    map[MessagePage.CONVERSATION_TYPE] = conversationType;
    Navigator.pushNamed(context, ConstRouter.CHAT_DETAIL_PAGE, arguments: map);
  }
}
