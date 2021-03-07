import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/view/mmk_widgets.dart';

import '../model/Defect.dart';
import '../model/DefectModel.dart';
import '../model/IssueModel.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    var defectModel = DefectModel();
    return BlocConsumer<DefectModel, Defect>(
      cubit: defectModel,
      builder: (context, state) {
        var issueModel = context.read<IssueModel>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Дефект'),
            actions: [
              IconButton(
                tooltip: 'Сканировать штрихкод',
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Добавить изображение',
                icon: Icon(Icons.photo_library),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Сфотографировать',
                icon: Icon(Icons.add_a_photo),
                onPressed: () {},
              ),
            ],
          ),
          body: Hpadding1(
            Column(
              children: [
                TextField(
                  controller: TextEditingController(text: state.productType),
                  decoration: InputDecoration(labelText: 'Вид продукции'),
                  onChanged: (v) => defectModel.set(productType: v),
                ),
                TextField(
                  controller: TextEditingController(text: state.notes),
                  decoration: InputDecoration(labelText: 'Замечания'),
                  onChanged: (v) => defectModel.set(notes: v),
                  minLines: 5,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 5),
            child: Text('Изображений: ${state.photos.length}'),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Сохранить',
            child: Icon(Icons.save),
            onPressed: () => _add(context, state, issueModel),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  void _add(context, state, issueModel) {
    issueModel.add(Defect()
      ..productType = state.productType
      ..notes = state.notes);

    Navigator.pop(context);
  }
}
