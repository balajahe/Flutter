import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../entity/Defect.dart';
import '../model/IssueModel.dart';
import '../view/DefectAdd.dart';
import '../tools/common_widgets.dart';

class IssueAdd extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<IssueModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Претензия'),
        actions: [
          IconButton(
            tooltip: 'Отправить претензию',
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Добавить дефект',
            icon: Icon(Icons.add, size: 40),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DefectAdd())),
          ),
          Container(width: 15),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 7, top: 3),
        child: BlocBuilder<IssueModel, Issue>(
          builder: (context, state) {
            return (state.defects.length > 0)
                ? ListView(
                    children: state.defects.map((v) => _DefectTile(v, model)).toList(),
                  )
                : Center(
                    child:
                        Hpadding2(Text('Нажмите "+" чтобы добавить дефект в претензию', textAlign: TextAlign.center)),
                  );
          },
        ),
      ),
    );
  }
}

class _DefectTile extends StatelessWidget {
  final Defect defect;
  final IssueModel issueModel;
  _DefectTile(this.defect, this.issueModel);

  @override
  build(context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 5),
              Row(
                children: [
                  Expanded(flex: 2, child: Text('Серт. №', style: gridHeaderStyle)),
                  Expanded(flex: 3, child: Text(defect.certificate.name)),
                ],
              ),
              Hline1(),
              Row(
                children: [
                  Expanded(flex: 2, child: Text('Вид продукции', style: gridHeaderStyle)),
                  Expanded(flex: 3, child: Text(defect.productType)),
                ],
              ),
              Hline1(),
              Row(
                children: [
                  Expanded(flex: 2, child: Text('Дефект', style: gridHeaderStyle)),
                  Expanded(flex: 3, child: Text(defect.defectType.name)),
                ],
              ),
              Hline2(),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _del(context, issueModel, defect),
        ),
      ],
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
