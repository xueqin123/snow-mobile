library imlib;

import 'package:imlib/core/snow_im_context.dart';

export 'package:imlib/imlib.dart';
export 'package:imlib/utils/s_log.dart';

class SnowIMLib {
  static connect(String token, uid) async {
    return SnowIMContext.getInstance().connect(token, uid);
  }

  static getConnectStatusStream() {
    return SnowIMContext.getInstance().getConnectStatusController();
  }

  static sendMessage() {}
}
