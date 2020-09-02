import 'package:flutter/material.dart';
import 'package:imlib/proto/message.pb.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snowclient/pages/message/widget/plugin/plugin.dart';
import 'package:snowclient/rest/http_manager.dart';
import 'package:snowclient/rest/service/upload_service.dart';

class ImagePlugin extends Plugin {

  UploadService uploadService;
  ImagePicker imagePicker;

  ImagePlugin() {
    imagePicker = ImagePicker();
    uploadService = HttpManager.getInstance().getService<UploadService>();
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
  onClick(String conversationId,ConversationType type) async {
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    SLog.i("gallery file: $pickedFile path:${pickedFile.path}");
    String url = await uploadService.upLoadImage(pickedFile.path);
    SLog.i("upload success url:$url");
  }



  @override
  int getOrder() {
    return 0;
  }
}
