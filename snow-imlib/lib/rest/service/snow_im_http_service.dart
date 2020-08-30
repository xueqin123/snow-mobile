import 'package:imlib/rest/snow_im_http_helper.dart';

abstract class SnowIMHttpService {
  SnowIMHttpHelper _httpHelper;

  SnowIMHttpHelper get httpHelper => _httpHelper;

  SnowIMHttpService(this._httpHelper);
}
