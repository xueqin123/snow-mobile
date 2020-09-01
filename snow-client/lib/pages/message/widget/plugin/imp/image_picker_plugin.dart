import 'package:flutter/material.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin.dart';

class ImagePickerPlugin extends Plugin {
  ImagePicker imagePicker;

  @override
  Widget getIcon() {
    return Icon(Icons.insert_photo);
  }

  @override
  String getName() {
    return S.current.pluginImage;
  }

  @override
  onClick(String conversationId,ConversationType type) async {
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    SLog.i("pickfile: ${pickedFile.path}");
  }

  ImagePickerPlugin() {
    imagePicker = ImagePicker();
  }

  @override
  int getOrder() {
    return 0;
  }
}
