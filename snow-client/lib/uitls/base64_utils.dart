import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64Utils {
  static Future<String> file2Base64(String path) async {
    Uint8List uint8list = await File(path).readAsBytes();
    return base64Encode(uint8list);
  }

  Image base642Image(String base64Str, double width, double height) {
    Uint8List bytes = Base64Decoder().convert(base64Str);
    return Image.memory(bytes, fit: BoxFit.cover, width: width, height: height);
  }
}
