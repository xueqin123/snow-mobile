import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';
import 'package:snowclient/pages/base_view_model.dart';

class ContactViewModel extends BaseViewModel with ChangeNotifier {
  ContactModel contactModel;

  ContactViewModel() {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
  }

  StreamController<List<UserEntity>> getAllUserController() {
    return contactModel.getAllUserController();
  }

  Stream<int> getTestStream(){
    return Stream.periodic(Duration(seconds: 1),(i)=>i);
  }
}
