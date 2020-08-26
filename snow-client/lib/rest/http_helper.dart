import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:imlib/imlib.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snowclient/generated/json/base/json_convert_content.dart';

class HttpHelper {
  static const String _BASE_URL = "http://172.24.80.152:8080/api";

  final Dio dio = Dio();

  Future<CookieJar> _getCookieJar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    return PersistCookieJar(dir: path);
  }

  Future init() async {
    CookieJar cookieJar = await _getCookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    SLog.i("HttpHelper init success");
  }

  Future<T> post<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'POST'));
  }

  Future<T> get<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'GET'));
  }

  Future<T> put<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'PUT'));
  }

  Future<T> request<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson, Options opt) async {
    try {
      Response response = await dio.request(_BASE_URL + path, data: bodyJson, queryParameters: params, options: opt);
      if (response != null && response.statusCode == 200) {
        var resultJson = response.data;
        int code = resultJson["code"];
        String msg = resultJson["msg"];
        dynamic data = resultJson["data"];
        if (code == 10000) {
          T t = JsonConvert.fromJsonAsT<T>(data);
          return t;
        } else {
          SLog.i("http request response: $response ");
        }
      } else {
        SLog.i("http request failed response: $response ");
      }
    } catch (e) {
      SLog.i("http request failed reason: Exception: $e");
    }
    return null;
  }
}
