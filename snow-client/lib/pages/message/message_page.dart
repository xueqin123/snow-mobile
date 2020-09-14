import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/model/message_model.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/message/widget/message_input_widget.dart';
import 'package:snowclient/uitls/const_router.dart';
import 'package:snowclient/uitls/widge/portrait_widget.dart';

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
          initialData: <MessageWrapper>[],
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
  List<MessageWrapper> data;
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
    data = Provider.of<List<MessageWrapper>>(context);
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
              child: Listener(
                onPointerDown: (_) => inputWidget.unFocusTextInput(),
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildCustomMessageItemWidget(context, index),
                  itemCount: data.length,
                ),
              ),
            ),
          ),
          inputWidget
        ],
      ),
    );
  }

  Widget _buildCustomMessageItemWidget(BuildContext context, int index) {
    SLog.i("data size:${data.length}");
    MessageWrapper messageWrapper = data[index];
    CustomMessage customMessage = data[index].customMessage;
    MainAxisAlignment alignment;
    EdgeInsets sendPadding = const EdgeInsets.only(
      left: 60,
      top: 5,
      right: 14,
      bottom: 5,
    );
    EdgeInsets receivePadding = const EdgeInsets.only(
      left: 14,
      top: 5,
      right: 60,
      bottom: 5,
    );
    EdgeInsets rootPadding;
    if (customMessage.direction == Direction.SEND) {
      alignment = MainAxisAlignment.end;
      rootPadding = sendPadding;
    } else {
      alignment = MainAxisAlignment.start;
      rootPadding = receivePadding;
    }
    return Container(
      padding: rootPadding,
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: customMessage.status != SendStatus.SUCCESS,
            child: _buildSendDot(customMessage.status),
          ),
          Visibility(
            visible: customMessage.direction == Direction.RECEIVE,
            child: _buildPortrait(messageWrapper),
          ),
          _buildMessageContent(context,customMessage),
          Visibility(
            visible: customMessage.direction == Direction.SEND,
            child: _buildPortrait(messageWrapper),
          )
        ],
      ),
    );
  }

  _buildMessageContent(BuildContext context,CustomMessage customMessage) {
    SLog.i("_buildMessageContent customMessage.cid =  ${customMessage.cid}");
    MessageWidgetProvider provider = MessageWidgetManager.getInstance().getMessageWidgetProvider(customMessage.type);
    if (provider != null) {
      return provider(context,customMessage);
    } else {
      return Text(S.of(context).unSupportMessage,style: TextStyle(color: Colors.grey,fontSize: 10),);
    }
  }

  _buildPortrait(MessageWrapper messageWrapper) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          PortraitWidget(messageWrapper.userEntity.portrait, 40),
          Text(
            messageWrapper.userEntity.name,
            style: TextStyle(fontSize: 8),
          )
        ],
      ),
    );
  }

  Widget _buildSendDot(SendStatus status) {
    switch (status) {
      case SendStatus.FAILED:
        return Material(
          type: MaterialType.circle,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "!",
              style: TextStyle(fontSize: 10),
            ),
          ),
        );
        break;
      case SendStatus.SENDING:
      case SendStatus.PERSIST:
        return Material(
          type: MaterialType.circle,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              ".",
              style: TextStyle(fontSize: 10),
            ),
          ),
        );
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
