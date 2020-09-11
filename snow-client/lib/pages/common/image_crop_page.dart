import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:snowclient/generated/l10n.dart';

class ImageCropPage extends StatelessWidget {
  static const String ORIGIN_FILE_PATH = "origin_file_path";
  final imgCropKey = GlobalKey<ImgCropState>();
  String originFilePath;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    originFilePath = args[ImageCropPage.ORIGIN_FILE_PATH];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).cropPortrait),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: () => _startCrop(context))],
      ),
      body: _buildCropImage(),
    );
  }

  _startCrop(BuildContext context) async {
    print("_startCrop()");
    final crop = imgCropKey.currentState;
    final croppedFile = await crop.cropCompleted(File(originFilePath),pictureQuality: 600);
    Navigator.pop(context, croppedFile.path);
  }

  Widget _buildCropImage() {
    return Container(
      color: Colors.black,
      child: ImgCrop(
        key: imgCropKey,
        chipRadius: 150, // crop area radius
        chipShape: 'circle', // crop type "circle" or "rect"
        image: FileImage(File(originFilePath)), // you selected image file
      ),
    );
  }
}
