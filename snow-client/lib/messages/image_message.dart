import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:imlib/message/custom_message.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/message/message_view_model.dart';

class ImageMessage extends CustomMessage {
  String localPath;
  String remoteUrl;
  String base64;
  bool isOriginal;
  Uint8List bytes;
  int width;
  int height;

  ImageMessage({this.localPath});

  @override
  decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    remoteUrl = map["remoteUrl"];
    base64 = map["base64"];
    isOriginal = map["isOriginal"];
    width = map["width"];
    height = map["height"];
    bytes = base64Decode(base64);
  }

  @override
  String encode() {
    Map<String, dynamic> map = Map();
    map["remoteUrl"] = remoteUrl;
    map["base64"] = base64;
    map["isOriginal"] = isOriginal;
    map["width"] = width;
    map["height"] = height;
    return jsonEncode(map);
  }
}

Widget buildImageMessageWidget(BuildContext context, CustomMessage customMessage) {
  SLog.i("ImageMessage buildImageMessageWidget ${customMessage.cid}");
  ImageMessage imageMessage = customMessage;
  double imageWidth = imageMessage.width == null ? null : imageMessage.width.toDouble();
  double imageHeight = imageMessage.height == null ? null : imageMessage.height.toDouble();
  SLog.i("ImageMessage imageWidth $imageWidth imageHeight:$imageHeight");
  double maxwidth = 250.0;
  double maxHeight = imageHeight*maxwidth/imageWidth;
  return Container(
    width: maxwidth,
    height: maxHeight,
    child: Stack(
      children: [
        Image.memory(imageMessage.bytes),
        Align(
          alignment: Alignment.center,
          child: _buildProgress(context, customMessage),
        )
      ],
    ),
  );
}

Widget _buildProgress(BuildContext context, CustomMessage customMessage) {
  MessageViewModel viewModel = Provider.of<MessageViewModel>(context);
  return Visibility(
    visible: customMessage.cid != null && (customMessage.status == SendStatus.SENDING || customMessage.status == SendStatus.PERSIST),
    child: Container(
      width: 40,
      height: 20,
      decoration: ShapeDecoration(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: ChangeNotifierProvider(
        create: (context) => viewModel.getProgressViewModel(customMessage.cid),
        child: Consumer(builder: (BuildContext context, ProgressViewModel progressViewModel, Widget child) {
          return _buildProgressText(progressViewModel.progressInfo.progress);
        }),
      ),
    ),
  );
}

_buildProgressText(int progress) {
  SLog.i("_buildProgressText $progress");
  return Text("$progress%");
}

String buildImageLast(String lastContent) {
  return S.current.image;
}

ImageMessage buildEmptyImageMessage() {
  return ImageMessage();
}
