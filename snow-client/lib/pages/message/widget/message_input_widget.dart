import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin_manager.dart';

typedef SendClick = Function();

class MessageInputWidget extends StatefulWidget {
  List<Plugin> plugins;
  TextEditingController controller;
  SendClick sendClick;
  FocusNode inputFocusNode = FocusNode();
  String conversationId;
  ConversationType conversationType;

  unFocusTextInput() {
    inputFocusNode.unfocus();
  }

  @override
  State<StatefulWidget> createState() {
    return InputState();
  }

  MessageInputWidget() {
    plugins = PluginManager.getInstance().getAllPlugin();
    plugins.sort((a, b) {
      return a.getOrder() - b.getOrder();
    });
  }
}

class InputState extends State<MessageInputWidget> {
  InputType inputType = InputType.IDLE;

  @override
  void initState() {
    widget.inputFocusNode.addListener(() {
      setState(() {
        if (widget.inputFocusNode.hasFocus) {
          inputType = InputType.IDLE;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_buildInputBarWidget(), Visibility(visible: inputType == InputType.FUNCTION, child: _buildFunctionWidget(context))],
    );
  }

  Widget _buildFunctionWidget(BuildContext context) {
    return Container(height: 350, child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1),
        itemBuilder: (context, index) => _buildItem(context,widget.plugins[index]),
        itemCount: widget.plugins.length));
  }

  Widget _buildItem(BuildContext context,Plugin plugin) {
    return GestureDetector(
      onTap: ()=>plugin.onClick(context,widget.conversationId,widget.conversationType),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
          ),
          plugin.getIcon(),
          Expanded(
            child: Text(
              plugin.getName(),
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputBarWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 10)),
              controller: widget.controller,
              focusNode: widget.inputFocusNode,
              maxLines: null,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          width: 60,
          height: 50,
          child: Stack(
            children: [
              Visibility(
                visible: !widget.inputFocusNode.hasFocus,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if(inputType == InputType.IDLE){
                        inputType = InputType.FUNCTION;
                      }else{
                        inputType = InputType.IDLE;
                      }
                    });
                  },
                  icon: Icon(Icons.add_circle),
                ),
              ),
              Visibility(
                  visible: widget.inputFocusNode.hasFocus,
                  child: GestureDetector(
                    onTap: () {
                      widget.inputFocusNode.unfocus();
                      widget.sendClick();
                    },
                    child: Container(
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
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

enum InputType { IDLE, FUNCTION }
