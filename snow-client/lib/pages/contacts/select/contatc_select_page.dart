import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowclient/generated/l10n.dart';
import 'package:snowclient/pages/contacts/select/contact_select_view_model.dart';

class ContactSelectPage extends StatelessWidget {
  ContactSelectViewModel viewModel = ContactSelectViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (_) => viewModel)]);
  }
}

class ContactSelectStatefulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {}
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
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: viewModel.checkUserList.length,
      ),
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
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.account_box),
            ),
            Expanded(
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(viewModel.checkUserList[index].userEntity.name),
                ),
                Align(
                  alignment: Alignment.bottomRight,
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
}
