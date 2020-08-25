import 'dart:async';

abstract class Notifier<T> {
  // ignore: close_sinks
  StreamController<T> _streamController = StreamController<T>();
  StreamController<T> get streamController => _streamController;

  Future post();
}
