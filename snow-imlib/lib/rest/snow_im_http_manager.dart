import 'package:imlib/rest/service/snow_im_group_service.dart';
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
    SnowIMGroupService groupService = SnowIMGroupService(_httpHelper);
    registerService(hostService);
    registerService(groupService);
  }

  registerService(SnowIMHttpService service){
    serviceMap[service.runtimeType.toString()] = service;

  }

  T getService<T>() {
    return serviceMap[T.toString()] as T;
  }
}
