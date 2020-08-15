import 'package:snowclient/rest/http_helper.dart';

abstract class HttpService {
  HttpHelper _httpHelper;

  HttpHelper get httpHelper => _httpHelper;

  HttpService(this._httpHelper);
}
