import 'package:fixnum/fixnum.dart';
class SnowIMUtils{
  static Int64 generateCid() {
    return Int64(currentTime());
  }

  static Int64 generateCidByTime(int time){
    return Int64(time);
  }

  static int currentTime(){
    return DateTime.now().millisecondsSinceEpoch;
  }
}