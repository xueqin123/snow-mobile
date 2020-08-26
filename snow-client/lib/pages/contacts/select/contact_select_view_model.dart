import 'package:flutter/material.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ContactSelectViewModel with ChangeNotifier {
  ContactModel contactModel;
  List<CheckUserWrapper> checkUserList = List();

  ContactSelectViewModel() {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    loadUserList();
  }

  loadUserList() async {
    List<UserEntity> userList = await contactModel.getAllUserList();
    print("ContactSelectViewModel userList.length:${userList.length}");
    checkUserList = userList.map((e) => _buildCheckWrapper(e)).toList();
    notifyListeners();
  }

  CheckUserWrapper _buildCheckWrapper(UserEntity userEntity) {
    return CheckUserWrapper(userEntity);
  }

  trigger(int index) {
    checkUserList[index].isCheck = !checkUserList[index].isCheck;
    notifyListeners();
  }
  getSelectIds(){
   checkUserList.where((element) => element.isCheck).length;
  }
}

class CheckUserWrapper {
  bool isCheck = false;
  UserEntity userEntity;

  CheckUserWrapper(this.userEntity);
}
