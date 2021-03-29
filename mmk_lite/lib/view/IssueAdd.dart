import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/IssueAddModel.dart';
import '../model/DefectModel.dart';
import 'lib/common_widgets.dart';
import 'DefectAdd.dart';

class IssueAdd extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<IssueAddModel, IssueAddState>(
      builder: (context, state) {
        var model = context.read<IssueAddModel>();
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAdd(DefectFormMode.add))),
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
  final IssueAddModel _model;
  _DefectTile(this._defect, this._model);

  @override
  build(context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAdd(DefectFormMode.edit, _defect))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 5),
                ViewField(label: 'Серт. №', text: _defect.certificate.name),
                Hline1(),
                ViewField(label: 'Вид продукции', text: _defect.productType),
                Hline1(),
                ViewField(label: 'Дефект', text: _defect.defectType.name),
                Hline2(),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _del(context, _model, _defect),
          ),
        ],
      ),
    );
  }
}

void _del(context, model, defect) async {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Удалить дефект?'),
      actions: <Widget>[
        TextButton(child: Text('Нет'), onPressed: () => Navigator.pop(context)),
        TextButton(
          child: Text('Да'),
          onPressed: () {
            model.delDefect(defect);
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
