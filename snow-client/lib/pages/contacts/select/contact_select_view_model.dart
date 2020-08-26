import 'package:flutter/material.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ContactSelectViewModel with ChangeNotifier {
  ContactModel contactModel;
  List<CheckUserWrapper> checkUserList = List();

  ContactSelectViewModel() {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    getAllCheckableUserList();
  }

  getAllCheckableUserList() async {
    List<UserEntity> userList = await contactModel.getAllUserList();
    checkUserList = userList.map((e) => _buildCheckWrapper(e)).toList();
    notifyListeners();
  }

  _buildCheckWrapper(UserEntity userEntity) {
    return CheckUserWrapper(userEntity);
  }

  trigger(int index) {
    checkUserList[index].isCheck = !checkUserList[index].isCheck;
    notifyListeners();
  }
}

class CheckUserWrapper {
  bool isCheck = false;
  UserEntity userEntity;

  CheckUserWrapper(this.userEntity);
}
