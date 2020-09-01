import 'dart:io';

import 'package:snowclient/upload/tencent_cos.dart';

class UpLoader {
  static const String _FILE_HOST = "https://bucket1-1257086843.cos.ap-beijing.myqcloud.com";

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

  Future<String> uploadImage(String secretId, String secretKey, String token, String filePath) async {
    Cos cos = Cos(secretId, secretKey, _FILE_HOST, token);
    String fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    String upLoadName = _currentUid + fileName;
    String imgUrl = await cos.upload('image/$upLoadName', File(filePath).readAsBytesSync());
    return imgUrl;
  }
}
