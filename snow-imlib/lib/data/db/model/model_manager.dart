import 'package:imlib/data/db/model/conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';

class SnowIMModelManager {
  static SnowIMModelManager _instance;
  Map<String, SnowIMModel> _models = Map<String, SnowIMModel>();

  SnowIMModelManager._();

  static SnowIMModelManager getInstance() {
    if (_instance == null) {
      _instance = SnowIMModelManager._();
      ConversationModel conversationModel = ConversationModel();
      _instance.register(conversationModel.runtimeType.toString(), conversationModel);
    }
    return _instance;
  }

  void register(String type, SnowIMModel model) {
    _models[type] = model;
  }

  T getModel<T>() {
    return _models[T.toString()] as T;
  }
}
