class SLog {
  static int _leve = 0;
  static const tag ="[SLog]";
  static i(String msg) {
    if (_leve < 2) {
      print("$tag$msg");
    }
  }

  static v(String msg) {
    if (_leve < 1) {
      print("$tag$msg");
    }
  }
}
