import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class MineViewModel with ChangeNotifier {
  ContactModel contactModel;

  MineViewModel() {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
  }

  StreamController<UserEntity> getMineEntityStream() {
    UserEntity userEntity = contactModel.getCurrentUser();
    return contactModel.getUserController(userEntity.uid);
  }

  Future<bool> updatePortrait(String path) async{
    UserEntity userEntity = contactModel.getCurrentUser();
    return contactModel.upDataUserPortrait(userEntity.uid, path);
  }
}
