class SLog {
  static int leve = 1;

  static i(String msg) {
    if (leve < 2) {
      print("SLog_$msg");
    }
  }

  static v(String msg) {
    if (leve < 1) {
      print("SLog_$msg");
    }
  }
}
