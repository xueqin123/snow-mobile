import 'package:dio/dio.dart';
import 'package:imlib/generated/json/base/json_convert_content.dart';
import 'package:imlib/imlib.dart';

import 'base_result.dart';

class SnowIMHttpHelper {
  static const String _BASE_URL = "http://172.24.81.82:8010/snow";

  final Dio dio = Dio();

  String _token;

  SnowIMHttpHelper(this._token);

  Future<BaseResult<T>> post<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'POST'));
  }

  Future<BaseResult<T>> get<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'GET'));
  }

  Future<BaseResult<T>> put<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'PUT'));
  }

  Future<BaseResult<T>> del<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson) async {
    return request<T>(path, params, bodyJson, Options(method: 'DELETE'));
  }

  Future<BaseResult<T>> request<T>(String path, Map<String, dynamic> params, Map<String, dynamic> bodyJson, Options opt) async {
    try {
      opt.headers["Token"] = _token;
      SLog.i("request url: ${_BASE_URL + path} token:$_token");
      Response response = await dio.request(_BASE_URL + path, data: bodyJson, queryParameters: params, options: opt);
      if (response != null && response.statusCode == 200) {
        var resultJson = response.data;
        int code = resultJson["code"];
        String msg = resultJson["msg"];
        dynamic data = resultJson["data"];
        SLog.i("snowIM http request response: $response ");
        if(data == null){
          return BaseResult(code, msg, null);
        }else{
          T t = JsonConvert.fromJsonAsT<T>(data);
          return BaseResult(code, msg, t);
        }
      } else {
        SLog.i("snowIM  http request failed response: $response ");
      }
    } catch (e) {
      SLog.i("snowIM http request failed reason: Exception: $e");
    }
    return null;
  }
}
