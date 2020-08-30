import 'package:flutter/material.dart';
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/imlib.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/data/model/contact_model.dart';
import 'package:snowclient/data/model/model_manager.dart';

class ContactSelectViewModel with ChangeNotifier {
  ContactModel contactModel;
  List<CheckUserWrapper> data = List();

  ContactSelectViewModel() {
    contactModel = ModelManager.getInstance().getModel<ContactModel>();
    loadUserList();
  }

  loadUserList() async {
    List<UserEntity> userList = await contactModel.getAllUserList();
    print("ContactSelectViewModel userList.length:${userList.length}");
    data = userList.map((e) => _buildCheckWrapper(e)).toList();
    notifyListeners();
  }

  CheckUserWrapper _buildCheckWrapper(UserEntity userEntity) {
    return CheckUserWrapper(userEntity);
  }

  trigger(int index) {
    data[index].isCheck = !data[index].isCheck;
    notifyListeners();
  }

  Future<GroupEntity> createGroup() async {
    List<String> memberIds = List();
    String name = "";
    data.forEach((element) {
      if (element.isCheck) {
        memberIds.add(element.userEntity.uid);
        name += ("," + element.userEntity.name);
      }
    });
    String groupName = name.substring(1, name.length);
    if (memberIds.isEmpty || name.isEmpty || memberIds.length < 3) {
      return null;
    }
    return SnowIMLib.createGroup(groupName, "fake", memberIds);
  }
}

class CheckUserWrapper {
  bool isCheck = false;
  UserEntity userEntity;

  CheckUserWrapper(this.userEntity);
}
