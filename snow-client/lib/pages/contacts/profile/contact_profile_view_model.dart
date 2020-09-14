import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ContactProfileViewModel with ChangeNotifier{

  ContactModel contactModel;
  String selfUid;
  ContactProfileViewModel(){
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    selfUid = contactModel.getCurrentUser().uid;
  }

  StreamController<UserEntity> getUserEntityStream(String uid){
    return contactModel.getUserController(uid);
  }
}