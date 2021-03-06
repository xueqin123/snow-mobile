import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/model/message_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/message/message_view_model.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin.dart';
import 'package:snowclient/rest/service/upload_service.dart';

class ImagePlugin extends Plugin {
  UploadService uploadService;
  ImagePicker imagePicker;
  MessageModel messageModel;

  ImagePlugin() {
    imagePicker = ImagePicker();
    messageModel = ModelManager.getInstance().getModel<MessageModel>();
  }

  @override
  Widget getIcon() {
    return Icon(Icons.insert_photo);
  }

  @override
  String getName() {
    return S.current.pluginImage;
  }

  @override
  onClick(BuildContext context, String conversationId, ConversationType type) async {
    MessageViewModel viewModel = Provider.of<MessageViewModel>(context);
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    SLog.i("gallery file: $pickedFile path:${pickedFile.path} messageModel:$messageModel");
    String localPath = pickedFile.path;
    if (localPath != null && localPath.isNotEmpty) {
      viewModel.sendImageMessage(localPath);
    }
  }

  @override
  int getOrder() {
    return 0;
  }
}
