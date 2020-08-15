import 'dart:async';

abstract class Notifier<T> {
  StreamController<T> _streamController = StreamController<T>();
  StreamController<T> get streamController => _streamController;

  Future post();
}
