import 'package:flutter/material.dart';
import 'package:imlib/imlib.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/login_model.dart';
import 'package:snowclient/data/model/snow_model.dart';

class ModelManager {
  static ModelManager _instance;
  Map<String, SnowModel> _models = Map<String, SnowModel>();

  ModelManager._();

  static ModelManager getInstance() {
    if (_instance == null) {
      _instance = ModelManager._();
      LoginModel loginModel = LoginModel();
      _instance.register(loginModel.runtimeType.toString(), loginModel);
    }
    return _instance;
  }

  void init() {
    ContactModel contactModel = ContactModel();
    register(contactModel.runtimeType.toString(), ContactModel());
    SLog.i("ModelManager init success");
  }

  void register(String type, SnowModel model) {
    _models[type] = model;
  }

  T getModel<T>() {
    return _models[T.toString()] as T;
  }
}
