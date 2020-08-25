import 'package:dio/dio.dart';
import 'package:imlib/utils/s_log.dart';

class HostHelper {
  static const String _SOCKET_REQUEST = "http://172.24.81.52:8010/snow/admin/server/socket";

  Dio dio = Dio();

  Future<HostInfo> getHost(String token) async {
    try{
      Options opt = Options();
      opt.headers["Token"] = token;
      Response response = await dio.get(_SOCKET_REQUEST, options: opt);
      if (response != null && response.statusCode == 200) {
        var resultJson = response.data;
        int code = resultJson["code"];
        String msg = resultJson["msg"];
        if (code == 10000) {
          dynamic data = resultJson["data"];
          String host = data["ip"];
          int port = data["port"];
          return HostInfo(host, port);
        }
      }
    }catch(e){
      SLog.i("getHost e:$e");
    }

    return null;
  }
}

class HostInfo {
  String host;
  int port;

  HostInfo(this.host, this.port);

  @override
  String toString() {
    return 'HostInfo{host: $host, port: $port}';
  }
}
