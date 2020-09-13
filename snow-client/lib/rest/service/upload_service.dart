import 'package:imlib/utils/s_log.dart';
import 'package:snowclient/data/entity/rsp_credential_entity.dart';
import 'package:snowclient/rest/base_result.dart';
import 'package:snowclient/rest/http_helper.dart';
import 'package:snowclient/upload/uploader.dart';

import 'http_service.dart';

class UploadService extends HttpService {
  UploadService(HttpHelper httpHelper) : super(httpHelper);
  static const String _FILE_CREDENTIAL = "/file/credential";

  Future<String> upLoadImage(String filePath,{Function(int, int) progress}) async {
    BaseResult<RspCredentialEntity> result = await httpHelper.get<RspCredentialEntity>(_FILE_CREDENTIAL, null, null);
    RspCredentialEntity credential = result.data;
    SLog.i("upLoadImage credential: ${credential.toJson()}");
    String url = await UpLoader.getInstance().uploadImage(credential.tmpSecretId, credential.tmpSecretKey, credential.sessionToken, filePath,progress: progress);
    SLog.i("upLoadImage: $url");
    return url;
  }
}
