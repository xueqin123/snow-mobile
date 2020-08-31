import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/chat/detail/chat_detail_view_model.dart';

class ChatDetailPage extends StatelessWidget {
  static const String TARGET_ID = "target_id";
  static const String CONVERSATION_TYPE = "conversation_type";
  String targetId;
  ConversationType conversationType;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    targetId = args[TARGET_ID];
    conversationType = args[CONVERSATION_TYPE];
    ChatDetailViewModel viewModel = ChatDetailViewModel(targetId, conversationType);

    return MultiProvider(
      providers: [
        FutureProvider(create: (_) => viewModel.getChatName(),
        initialData: "",),
        ChangeNotifierProvider(create: (_) => viewModel),
      ],
      child: ChatDetailStatefulPage(targetId, conversationType),
    );
  }
}

class ChatDetailStatefulPage extends StatefulWidget {
  String targetId;
  ConversationType conversationType;

  ChatDetailStatefulPage(this.targetId, this.conversationType);

  @override
  State<StatefulWidget> createState() {
    return ChatDetailState();
  }
}

class ChatDetailState extends State<ChatDetailStatefulPage> {
  ChatDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<String>(context);
    viewModel = Provider.of<ChatDetailViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: widget.conversationType == ConversationType.GROUP,
              child: RaisedButton(
                onPressed: () => _dismissGroup(widget.targetId),
                child: Text(S.of(context).dissmissGroup),
              ))
        ],
      ),
    );
  }

  _dismissGroup(String targetId) async {
    bool isSuccess = await viewModel.dismissGroup(targetId);
    if (isSuccess) {
      Fluttertoast.showToast(msg: S.of(context).dissmissGroupSuccess,textColor: Colors.black45);
    } else {
      Fluttertoast.showToast(msg: S.of(context).dissmissGroupFailed,textColor: Colors.black45);
    }
  }
}
