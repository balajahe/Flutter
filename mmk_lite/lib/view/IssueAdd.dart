import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/model/IssueModel.dart';
import 'package:mmk_lite/view/mmk_widgets.dart';

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
                  child: Hpadding2(Text(
                  'Нажмите "+" чтобы добавить дефект в дело',
                  textAlign: TextAlign.center,
                )))
              : ListView(
                  children: state.defects
                      .map((v) => ListTile(
                            title: Text(v.productType),
                            subtitle: Text(v.notes),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _del(context, model, v),
                            ),
                          ))
                      .toList(),
                );
        },
      ),
    );
  }

  void _del(context, model, v) async {
    //   showDialog<void>(
    //   context: context,
    //   builder: (BuildContext context) => AlertDialog(
    //     title: Text('Удалить объект?'),
    //     actions: <Widget>[
    //       TextButton(
    //           child: Text('Нет'), onPressed: () => Navigator.pop(context)),
    //       TextButton(
    //           child: Text('Да'),
    //           onPressed: () async {
    //             startWaiting(context);
    //             try {
    //               await context.read<Places>().del(_place);
    //             } catch (e) {
    //               await showError(context, e);
    //             }
    //             stopWaiting(context);
    //             Navigator.pop(context);
    //             Navigator.pop(context);
    //           }),
    //     ],
    //   ),
    // );

    model.del(v);
  }
}
