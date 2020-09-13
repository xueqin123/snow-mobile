import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:imlib/imlib.dart';
import 'package:path_provider/path_provider.dart';

class MediaCompressUtils {
  static const int _UPLOAD_MAX_SIZE = 100 * 1000;

  static Future<String> compressImage(String originPath, int width, int height) async {
    int originLength = File(originPath).lengthSync();
    print("before compress file size: $originLength");
    if (originLength < _UPLOAD_MAX_SIZE) {
      return originPath;
    }
    Directory directory = await getTemporaryDirectory();
    String cachePath = directory.path;
    String filename = originPath.substring(originPath.lastIndexOf("/") + 1);
    String targetPath = "$cachePath/compressed_$filename";
    File compressedFile = await FlutterImageCompress.compressAndGetFile(
      originPath,
      targetPath,
      quality: 100,
      minHeight: width,
      minWidth: height,
    );
    print("after compress file size: ${compressedFile.lengthSync()}");
    return compressedFile.absolute.path;
  }

  static Future<String> compressImageByTargetWidth(String originPath, int targetWidth) async {
    File imageFile = File(originPath);
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
    int originWidth = decodedImage.width;
    int originHeight = decodedImage.height;
    double scale = targetWidth / originWidth;
    if (scale >= 1) {
      return originPath;
    }
    int targetHeight = (originHeight * scale).toInt();
    SLog.i("SnowImClient sendImageMessage originWidth:$originWidth originHeight:$originHeight scale:$scale targetWidth:$targetWidth targetHeight:$targetHeight");
    return compressImage(originPath, targetWidth, targetHeight);
  }
}

