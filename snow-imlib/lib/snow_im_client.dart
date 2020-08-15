class SnowIMClient {
  static SnowIMClient _instance;

  SnowIMClient._();

  static SnowIMClient getInstance() {
    if (_instance == null) {
      _instance = SnowIMClient._();
    }
    return _instance;
  }
}
