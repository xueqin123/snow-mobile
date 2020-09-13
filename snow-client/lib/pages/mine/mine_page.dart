import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imlib/utils/s_log.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/data/entity/user_entity.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/common/image_crop_page.dart';
import 'package:snowclient/pages/mine/mine_view_model.dart';
import 'package:snowclient/uitls/const_router.dart';
import 'package:snowclient/uitls/widge/portrait_widget.dart';
import 'package:snowclient/upload/media_compress_utils.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MineViewModel viewModel = MineViewModel();
    return MultiProvider(
      providers: [
        StreamProvider.controller(create: (_) => viewModel.getMineEntityController()),
        ChangeNotifierProvider(create: (_) => viewModel),
      ],
      child: MineStatefulPage(),
    );
  }
}

class MineStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MineState();
  }
}

class MineState extends State<MineStatefulPage> {
  UserEntity userEntity;
  MineViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    userEntity = Provider.of<UserEntity>(context);
    viewModel = Provider.of<MineViewModel>(context);
    SLog.i("MinePage build userEntity = $userEntity");
    String name = userEntity == null ? "" : userEntity.name;
    String phone = userEntity == null ? "" : userEntity.username;
    String uid = userEntity == null ? "" : userEntity.uid;
    String portraitUrl = userEntity == null ? "" : userEntity.portrait;
    return Column(
      children: [
        _buildHeader(name, portraitUrl),
        Divider(
          thickness: 10,
          height: 10,
          color: Colors.grey,
        ),
        _buildItem(phone),
        Divider(
          thickness: 10,
          height: 10,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildHeader(String name, String portraitUrl) {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          GestureDetector(
            onTap: _updatePortrait,
            child: Container(
              width: 60,
              height: 60,
              child: Align(
                alignment: Alignment.center,
                child: PortraitWidget(portraitUrl, 60),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 40.0),
                  ),
                  Text("地区: 中国")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _updatePortrait() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    String originPath = pickedFile.path;
    SLog.i("_updatePortrait originPath:$originPath");
    String croppedPath = await _getCropImage(originPath);
    SLog.i("_updatePortrait croppedPath:$croppedPath");
    String compressedPath = await MediaCompressUtils.compressImage(croppedPath, 480, 480);
    String remoteUrl = await viewModel.updatePortrait(compressedPath);
    if (remoteUrl != null) {
      Fluttertoast.showToast(msg: S.of(context).success, textColor: Colors.black45);
    } else {
      Fluttertoast.showToast(msg: S.of(context).failed, textColor: Colors.black45);
    }
  }

  Future<String> _getCropImage(String originPath) async {
    Map arg = Map();
    arg[ImageCropPage.ORIGIN_FILE_PATH] = originPath;
    var result = await Navigator.pushNamed(context, ConstRouter.IMAGE_CROP_PAGE, arguments: arg);
    return result;
  }

  Widget _buildItem(String phone) {
    return Container(
      color: Colors.white,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.phone),
          ),
          Text(
            phone,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ],
      ),
    );
  }
}
