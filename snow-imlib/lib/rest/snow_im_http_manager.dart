import 'package:imlib/rest/service/snow_im_host_service.dart';
import 'package:imlib/rest/service/snow_im_http_service.dart';
import 'package:imlib/rest/snow_im_http_helper.dart';

class SnowIMHttpManager {
  static SnowIMHttpManager _instance;
  SnowIMHttpHelper _httpHelper;

  SnowIMHttpManager._();

  Map<String, SnowIMHttpService> serviceMap = Map();

  static SnowIMHttpManager getInstance() {
    if (_instance == null) {
      _instance = SnowIMHttpManager._();
    }
    return _instance;
  }

  init(String token){
    _httpHelper = SnowIMHttpHelper(token);
    SnowIMHostService hostService = SnowIMHostService(_httpHelper);
    serviceMap[hostService.runtimeType.toString()] = hostService;
  }

  T getService<T>() {
    return serviceMap[T.toString()] as T;
  }
}
