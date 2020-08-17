class SLog {
  static bool isOpen = false;

  static i(String msg) {
    if (isOpen) {
      print("SLog_$msg");
    }
  }
}
