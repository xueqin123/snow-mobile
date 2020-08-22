import 'package:imlib/imlib.dart';
import 'package:snowclient/data/model/chat_model.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/login_model.dart';
import 'package:snowclient/data/model/base_model.dart';
import 'package:snowclient/data/model/message_model.dart';

class ModelManager {
  static ModelManager _instance;
  Map<String, BaseModel> _models = Map<String, BaseModel>();

  ModelManager._();

  static ModelManager getInstance() {
    if (_instance == null) {
      _instance = ModelManager._();
      LoginModel loginModel = LoginModel();
      _instance.register(loginModel);
    }
    return _instance;
  }

  void init() {
    ContactModel contactModel = ContactModel();
    ChatModel chatModel = ChatModel();
    MessageModel messageModel = MessageModel();
    register(contactModel);
    register(chatModel);
    register(messageModel);
    SLog.i("ModelManager init success");
  }

  void register(BaseModel model) {
    _models[model.runtimeType.toString()] = model;
  }

  T getModel<T>() {
    return _models[T.toString()] as T;
  }
}
