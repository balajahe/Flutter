import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Defect.dart';
import '../model/IssueModel.dart';
import '../model/DefectModel.dart';
import 'lib/common_widgets.dart';
import 'DefectAddEdit.dart';

class IssueAdd extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<IssueModel, IssueState>(
      builder: (context, state) {
        var model = context.read<IssueModel>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Новая претензия'),
            actions: [
              (state.data.defects.length > 0)
                  ? IconButton(
                      tooltip: 'Отправить претензию',
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    )
                  : Container(),
              IconButton(
                tooltip: 'Добавить дефект',
                icon: Icon(Icons.add, size: 40),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAddEdit(AddEditMode.add))),
              ),
              Container(width: 15),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 7, top: 3),
            child: (state.data.defects.length > 0)
                ? ListView(
                    children: state.data.defects.map((v) => _DefectTile(v, model)).toList(),
                  )
                : Center(
                    child:
                        Hpadding2(Text('Нажмите "+" чтобы добавить дефект в претензию', textAlign: TextAlign.center)),
                  ),
          ),
        );
      },
    );
  }
}

class _DefectTile extends StatelessWidget {
  final Defect _defect;
  final IssueModel _issueModel;
  _DefectTile(this._defect, this._issueModel);

  @override
  build(context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAddEdit(AddEditMode.edit, _defect))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 5),
                Row(
                  children: [
                    Expanded(flex: 2, child: Text('Серт. №', style: gridHeaderStyle)),
                    Expanded(flex: 3, child: Text(_defect.certificate.name)),
                  ],
                ),
                Hline1(),
                Row(
                  children: [
                    Expanded(flex: 2, child: Text('Вид продукции', style: gridHeaderStyle)),
                    Expanded(flex: 3, child: Text(_defect.productType)),
                  ],
                ),
                Hline1(),
                Row(
                  children: [
                    Expanded(flex: 2, child: Text('Дефект', style: gridHeaderStyle)),
                    Expanded(flex: 3, child: Text(_defect.defectType.name)),
                  ],
                ),
                Hline2(),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _del(context, _issueModel, _defect),
          ),
        ],
      ),
    );
  }
}

void _del(context, model, v) async {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Удалить дефект?'),
      actions: <Widget>[
        TextButton(child: Text('Нет'), onPressed: () => Navigator.pop(context)),
        TextButton(
          child: Text('Да'),
          onPressed: () {
            model.del(v);
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
