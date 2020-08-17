import 'package:fixnum/fixnum.dart';
class SnowIMUtils{
  static Int64 generateMessageId() {
    return Int64(DateTime.now().millisecondsSinceEpoch);
  }
}