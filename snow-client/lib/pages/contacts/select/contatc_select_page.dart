import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/contacts/select/contact_select_view_model.dart';

class ContactSelectPage extends StatelessWidget {
  ContactSelectViewModel viewModel = ContactSelectViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => viewModel)],
      child: ContactSelectStatefulPage(),
    );
  }
}

class ContactSelectStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactSelectState();
  }
}

class ContactSelectState extends State<ContactSelectStatefulPage> {
  ContactSelectViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ContactSelectViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).contactSelect),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: _buildItem,
            itemCount: viewModel.checkUserList.length,
          ),
          _buildBottomConfirm();
        ],
      )
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => viewModel.trigger(index),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Checkbox(
                value: viewModel.checkUserList[index].isCheck,
                onChanged: null,
                activeColor: Colors.blue,
              ),
            ),
            Expanded(
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Icons.account_box),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(viewModel.checkUserList[index].userEntity.name),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildBottomConfirm(){
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => _onConfirmClick(),
            child: Container(
              height: 35,
              decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context).messageSend,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _onConfirmClick(){
   String selectIds = viewModel.getSelectIds();
  }
}
