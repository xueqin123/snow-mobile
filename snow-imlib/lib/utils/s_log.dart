class SLog {
  static int _leve = 0;

  static i(String msg) {
    if (_leve < 2) {
      print("SLog_$msg");
    }
  }

  static v(String msg) {
    if (_leve < 1) {
      print("SLog_$msg");
    }
  }
}
