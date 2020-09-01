import 'package:snowclient/pages/message/widget/plugin/plugin.dart';

class PluginManager {
  List<Plugin> _list = List();

  PluginManager._();

  static PluginManager _instance;

  static PluginManager getInstance() {
    if (_instance == null) {
      _instance = PluginManager._();
    }
    return _instance;
  }

  addPlugin(Plugin plugin) {
    _list.add(plugin);
  }

  List<Plugin> getAllPlugin() {
    return _list;
  }
}
