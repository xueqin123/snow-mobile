import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imlib/proto/message.pbenum.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin.dart';

import '../../../message_view_model.dart';

class CameraPlugin extends Plugin{
  ImagePicker imagePicker;

  @override
  Widget getIcon() {
    return Icon(Icons.camera_alt);
  }

  @override
  String getName() {
    return S.current.pluginCamera;
  }

  @override
  int getOrder() {
    return 1;
  }

  @override
  onClick(BuildContext context,String conversationId, ConversationType conversationType) async{
    MessageViewModel viewModel = Provider.of<MessageViewModel>(context);
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    SLog.i("camera file: $pickedFile path:${pickedFile.path}");
    String localPath = pickedFile.path;
    if (localPath != null && localPath.isNotEmpty) {
      viewModel.sendImageMessage(localPath);
    }
  }

  CameraPlugin(){
    imagePicker = ImagePicker();
  }
}