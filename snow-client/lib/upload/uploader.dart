import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:snowclient/upload/tencent_cos.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> uploadImage(String secretId, String secretKey, String token, String path,{Function(int, int) progress}) async {
    Cos cos = Cos(secretId, secretKey, _FILE_HOST, token);
    String suffix = path.substring(path.lastIndexOf("."), path.length);
    String upLoadName = "${_currentUid}_${DateTime.now().millisecondsSinceEpoch}$suffix";
    String imgUrl = await cos.upload('/image/$upLoadName', File(path).readAsBytesSync(), progress: progress);
    return imgUrl;
  }


}
