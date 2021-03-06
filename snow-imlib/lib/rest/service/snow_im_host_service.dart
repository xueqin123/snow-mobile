import 'package:imlib/data/db/entity/host_entity.dart';
import 'package:imlib/rest/base_result.dart';
import 'package:imlib/rest/service/snow_im_http_service.dart';
import 'package:imlib/rest/snow_im_http_helper.dart';

class SnowIMHostService extends SnowIMHttpService {
  SnowIMHostService(SnowIMHttpHelper httpHelper) : super(httpHelper);
  static const String _SOCKET_REQUEST = "/admin/server/socket";

  Future<HostEntity> getHost(String token) async {
    BaseResult<HostEntity> baseResult = await httpHelper.get<HostEntity>(_SOCKET_REQUEST, null, null);
    return baseResult.data;
  }
}
