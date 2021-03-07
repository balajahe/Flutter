import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/model/IssueModel.dart';

import '../model/Issue.dart';
import '../model/IssueModel.dart';
import 'DefectAdd.dart';

class IssueAdd extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<IssueModel>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.text_snippet),
        title: Text('Новое дело'),
        actions: [
          IconButton(
            tooltip: 'Добавить дефект',
            icon: Icon(Icons.add, size: 35),
            onPressed: () => _add(context),
          ),
          Container(width: 15),
        ],
      ),
      body: BlocBuilder<IssueModel, Issue>(
        builder: (context, state) {
          return (state.defects.length == 0)
              ? Center(
                  child: (Text(
                  'Нажмите "+" чтобы добавить\nдефект в дело',
                  textAlign: TextAlign.center,
                )))
              : ListView(
                  children: state.defects
                      .map((v) => ListTile(
                            title: Text(v.productType),
                            subtitle: Text(v.notes),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => model.del(v),
                            ),
                          ))
                      .toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить дефект',
        child: Icon(Icons.add),
        onPressed: () => _add(context),
      ),
    );
  }

  void _add(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAdd()));
}
