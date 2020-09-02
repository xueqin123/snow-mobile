import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:mime/mime.dart';

/// 腾讯云对象存储工具类
/// 使用腾讯云secret_id,secret_key和存储桶地址来初始化
///
///   ```dart
///    String secret_id='xxxxxxx';
///    String secret_key='xxxxxxx';
///    String bucket_host='https://xxxxxx.cos.xxxxx.myqcloud.com';
///    Cos cos = Cos(secret_id, secret_key, bucket_host);
///   ```
/// 上传/更新文件
///   ```dart
///    String imgUrl = await cos.upload('/example.jpg', File('example.jpg').readAsBytesSync());
///   ```
/// 下载文件
///   ```dart
///    bool success = await cos.download(imgUrl, 'download/example.jpg');
///   ```
/// 删除文件
///   ```dart
///    bool success = await cos.delete('/example.jpg');
///   ```
class Cos {
  Dio dio = Dio();
  String id;
  String key;
  String host;
  String token;
  Cos(this.id, this.key, this.host,this.token);

  /// 上传文件成功后返回文件下载链接
  ///
  /// `path` : 存储桶文件存放路径
  ///
  /// `bytes` : 待上传文件二进制数组
  ///
  /// `params` : 请求参数
  ///
  /// `headers` : 请求头部
  ///
  /// `progress` : 上传进度回调函数，示例
  ///   ```dart
  ///   progress(int count, int total) {
  ///     double progress = (count / total) * 100;
  ///     if (progress % 5 == 0) print('上传进度---> ${progress.round()}%');
  ///   }
  ///  ```
  Future<String> upload(String path, List<int> bytes, {Map<String, String> params, Map<String, String> headers, Function(int, int) progress}) async {
    String url = host + path;
    params = params ?? Map<String, String>();
    String mimeType = lookupMimeType(path);
    print("upload path:$path mimeType:$mimeType");
    Options options = Options();
    options.headers = headers ?? Map<String, String>();
    options.headers[Headers.contentLengthHeader] = bytes.length.toString(); // 设置content-length,否则无法监听文件上传进度
    //对put上传请求签名
    options.headers['Authorization'] = sign('put', path, headers: options.headers, params: params);
    options.headers[Headers.contentTypeHeader] = mimeType;
    options.headers['x-cos-security-token'] = token;
    try {
      Response response = await dio.put(url,
          data: Stream.fromIterable(bytes.map((e) => [e])), //bytes转为Stream
          onSendProgress: progress ??
              (int count, int total) {
                double progress = (count / total) * 100;
                if (progress % 5 == 0) print('上传进度---> ${progress.round()}%');
              },
          queryParameters: params,
          options: options);
      return response.statusCode == 200 ? url : '';
    } on DioError catch (e) {
      print('Error: $e');
      return '';
    }
  }

  /// 删除在线文件
  ///
  /// `path` : 存储桶文件存放路径
  ///
  /// `params` : 请求参数
  ///
  /// `headers` : 请求头部
  ///
  Future<bool> delete(String path, {Map<String, String> params, Map<String, String> headers}) async {
    String url = host + path;
    params = params ?? Map<String, String>();
    Options options = Options();
    options.headers = headers ?? Map<String, String>();
    //对请求签名
    options.headers['Authorization'] = sign('DELETE', path, headers: options.headers, params: params);
    try {
      Response response = await dio.delete(url, queryParameters: params, options: options);
      return response.statusCode == 204 ? true : false;
    } on DioError catch (e) {
      print('Error:' + e.message);
      return false;
    }
  }

  /// 下载文件
  ///
  /// `urlPath` : 存储桶文件存放路径
  ///
  /// `savePath` : 文件保存路径
  ///
  /// `progress` : 下载进度回调函数，示例
  ///   ```dart
  ///   progress(int count, int total) {
  ///     double progress = (count / total) * 100;
  ///     if (progress % 5 == 0) print('下载进度---> ${progress.round()}%');
  ///   }
  ///  ```
  Future<bool> download(String urlPath, String savePath, {Function(int, int) progress}) async {
    try {
      await dio.download(urlPath, savePath,
          options: Options(receiveTimeout: 0),
          onReceiveProgress: progress ??
              (int count, int total) {
                double progress = (count / total) * 100;
                if (progress % 5 == 0) print('下载进度---> ${progress.round()}%');
              });
      return true;
    } on DioError catch (e) {
      print('Error:' + e.message);
      return false;
    }
  }

  /// 对http请求进行签名,返回Authorization签名字符串
  ///
  /// `httpMethod` : 请求方法
  ///
  /// `httpUrl` : 请求地址
  ///
  /// `params` : 请求参数
  ///
  /// `headers` : 请求头部
  ///
  String sign(String httpMethod, String httpUrl, {Map<String, String> headers, Map<String, String> params, int expire = 10}) {
    headers = headers ?? Map();
    params = params ?? Map();
    headers = headers.map((key, value) => MapEntry(key.toLowerCase(), value));
    params = params.map((key, value) => MapEntry(key.toLowerCase(), value));
    List<String> headerKeys = headers.keys.toList();
    headerKeys.sort();
    String headerList = headerKeys.join(';');
    String httpHeaders = headerKeys.map((item) => '$item=${Uri.encodeFull(headers[item])}').join('&');
    List<String> paramKeys = params.keys.toList();
    paramKeys.sort();
    String urlParamList = paramKeys.join(';');
    String httpParameters = paramKeys.map((item) => '$item=${Uri.encodeFull(params[item])}').join('&');
    String httpString = '${httpMethod.toLowerCase()}\n$httpUrl\n$httpParameters\n$httpHeaders\n';
    String httpStringData = sha1.convert(utf8.encode(httpString)).toString();
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String keyTime = '$timestamp;${timestamp + expire}';
    String signKey = Hmac(sha1, utf8.encode(key)).convert(utf8.encode(keyTime)).toString();
    String stringToSign = 'sha1\n$keyTime\n$httpStringData\n';
    String signature = Hmac(sha1, utf8.encode(signKey)).convert(utf8.encode(stringToSign)).toString();
    return 'q-sign-algorithm=sha1&q-ak=$id&q-sign-time=$keyTime&q-key-time=$keyTime&q-header-list=$headerList&q-url-param-list=$urlParamList&q-signature=$signature';
  }
}
