import 'package:imlib/data/db/dao/snow_im_dao_manager.dart';
import 'package:imlib/data/db/dao/snow_im_group_dao.dart';
import 'package:imlib/data/db/entity/group_entity.dart';
import 'package:imlib/data/db/model/snow_im_conversation_model.dart';
import 'package:imlib/data/db/model/snow_im_model.dart';
import 'package:imlib/rest/service/snow_im_group_service.dart';
import 'package:imlib/rest/snow_im_http_manager.dart';

class SnowIMGroupModel extends SnowIMModel {
  SnowIMGroupService groupService;
  SnowIMGroupDao groupDao;
  SnowIMConversationModel conversationModel;


  SnowIMGroupModel(){
    groupService = SnowIMHttpManager.getInstance().getService<SnowIMGroupService>();
    groupDao = SnowIMDaoManager.getInstance().getDao<SnowIMGroupDao>();
    conversationModel = SnowIMConversationModel();
  }

  Future<GroupEntity> createGroup(String name, String portrait, List<String> memberUidList) async {
    GroupEntity groupEntity = await groupService.createGroup(name, portrait, memberUidList);
    await groupDao.saveGroupEntity(groupEntity);
    await conversationModel.insertConversationByCreateGroup(groupEntity);
    return groupEntity;
  }

  Future<GroupEntity> getGroupDetailByConversationId(String conversationId) async{
    return groupDao.getGroupDetailByConversationId(conversationId);
  }


  Future syncGroupByGroupId(String groupId) async {
    GroupEntity groupEntity = await groupService.getGroupDetail(groupId);
    await groupDao.saveGroupEntity(groupEntity);
  }

  Future<bool> isGroupExist(String groupId) async {
    GroupEntity groupEntity = await groupDao.getGroupEntityByGroupId(groupId);
    return groupEntity != null;
  }
}
