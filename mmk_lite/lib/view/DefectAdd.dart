import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/view/mmk_widgets.dart';

import '../model/Defect.dart';
import '../model/DefectModel.dart';
import '../model/IssueModel.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    return BlocConsumer<DefectModel, Defect>(
      builder: (context, state) {
        var model = context.read<DefectModel>();
        var issueModel = context.read<IssueModel>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Дефект'),
            actions: [
              IconButton(
                tooltip: 'Добавить фото',
                icon: Icon(Icons.photo_library),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Сфотографировать',
                icon: Icon(Icons.photo_camera),
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
                ),
                TextField(
                  controller: TextEditingController(text: state.notes),
                  decoration: InputDecoration(labelText: 'Замечания'),
                  minLines: 5,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Hpadding2(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Изображений:'),
                TextButton(
                  child: Text('Сохранить'),
                  onPressed: () => _add(context, state),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  void _add(context, state) {
    // context.read<IssueModel>().add(Defect()
    //   ..productType = state.productType
    //   ..notes = state.notes);

    Navigator.pop(context);
  }
}
