import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:snowclient/upload/tencent_cos.dart';
import 'package:path_provider/path_provider.dart';

class UpLoader {
  static const String _FILE_HOST = "https://bucket1-1257086843.cos.ap-beijing.myqcloud.com";
  static const _UPLOAD_MAX_SIZE = 100;

  UpLoader._();

  static UpLoader _instance;
  String _currentUid;

  static UpLoader getInstance() {
    if (_instance == null) {
      _instance = UpLoader._();
    }
    return _instance;
  }

  init(String uid) {
    _currentUid = uid;
  }

  Future<String> uploadImage(String secretId, String secretKey, String token, String originPath) async {
    String compressedPath = await _compress(originPath);
    Cos cos = Cos(secretId, secretKey, _FILE_HOST, token);
    String suffix = compressedPath.substring(compressedPath.lastIndexOf("."), compressedPath.length);
    String upLoadName = "${_currentUid}_${DateTime.now().millisecondsSinceEpoch}$suffix";
    String imgUrl = await cos.upload('/image/$upLoadName', File(compressedPath).readAsBytesSync());
    return imgUrl;
  }

  Future<String> _compress(String originPath) async {
    int originLength = File(originPath).lengthSync();
    print("before compress file size: $originLength");
    if (originLength < UpLoader._UPLOAD_MAX_SIZE) {
      return originPath;
    }
    List<Directory> dirList = await getExternalCacheDirectories();
    print("dirList length: ${dirList.length}");
    for (Directory dir in dirList) {
      print("dir path: ${dir.path}");
    }
    String cachePath = dirList[0].path;
    String filename = originPath.substring(originPath.lastIndexOf("/") + 1);
    String targetPath = "${cachePath}compressed_$filename";
    File compressedFile = await FlutterImageCompress.compressAndGetFile(originPath, targetPath, quality: 50);
    print("after compress file size: ${compressedFile.lengthSync()}");
    return compressedFile.absolute.path;
  }
}
