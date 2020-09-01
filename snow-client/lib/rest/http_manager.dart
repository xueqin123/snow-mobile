import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/rest/service/login_service.dart';
import 'package:snowclient/rest/service/http_service.dart';
import 'package:snowclient/rest/service/upload_service.dart';
import 'package:snowclient/rest/service/user_service.dart';

class HttpManager {
  static HttpManager _instance;
  HttpHelper _httpHelper;

  HttpManager._();

  Map<String, HttpService> serviceMap = Map();

  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = HttpManager._();
    }
    return _instance;
  }

  Future init() async {
    _httpHelper = HttpHelper();
    await _httpHelper.init();
    UserService userService = UserService(_httpHelper);
    LoginService loginService = LoginService(_httpHelper);
    UploadService uploadService = UploadService(_httpHelper);
    serviceMap[userService.runtimeType.toString()] = userService;
    serviceMap[loginService.runtimeType.toString()] = loginService;
    serviceMap[uploadService.runtimeType.toString()] = uploadService;
  }

  T getService<T>() {
    return serviceMap[T.toString()] as T;
  }
}
