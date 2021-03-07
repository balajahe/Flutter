import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/model/IssueModel.dart';

import '../model/Issue.dart';
import '../model/IssueModel.dart';
import 'DefectAdd.dart';

class IssueAdd extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.text_snippet),
          title: Text('Новое дело'),
          actions: [
            IconButton(
              tooltip: 'Добавить дефект',
              icon: Icon(Icons.add, size: 40),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => DefectAdd())),
            ),
            Container(width: 15),
          ],
        ),
        body: BlocBuilder<IssueModel, Issue>(
          builder: (context, state) {
            return (state.defects.length == 0)
                ? Center(
                    child: (Text('Нажмите "+" чтобы добавить дефект в дело')))
                : ListView();
          },
        ));
  }
}
