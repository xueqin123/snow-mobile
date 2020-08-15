import 'dart:async';

import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ContactProfileViewModel{

  ContactModel contactModel;
  ContactProfileViewModel(){
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
  }

  StreamController<UserEntity> getUserEntityStream(String uid){
    return contactModel.getUserController(uid);
  }
}