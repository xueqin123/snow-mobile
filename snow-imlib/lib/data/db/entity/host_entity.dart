import 'package:imlib/generated/json/base/json_convert_content.dart';

class HostEntity with JsonConvert<HostEntity> {
	String ip;
	int port;

	@override
  String toString() {
    return 'HostEntity{ip: $ip, port: $port}';
  }
}
