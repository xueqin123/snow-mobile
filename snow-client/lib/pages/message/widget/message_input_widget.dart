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
      children: [_buildInputBarWidget(), Visibility(visible: inputType == InputType.FUNCTION, child: _buildFunctionWidget())],
    );
  }

  Widget _buildFunctionWidget() {
    return Container(height: 350, child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 1), itemBuilder: (context, index) => _buildItem(widget.plugins[index]), itemCount: widget.plugins.length));
  }

  Widget _buildItem(Plugin plugin) {
    return GestureDetector(
      onTap: ()=>plugin.onClick(widget.conversationId,widget.conversationType),
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
      children: [
        Expanded(
          child: Container(
            height: 35,
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: widget.controller,
              focusNode: widget.inputFocusNode,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          width: 60,
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
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

enum InputType { IDLE, FUNCTION }
