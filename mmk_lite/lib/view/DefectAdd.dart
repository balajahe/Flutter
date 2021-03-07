import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/view/mmk_widgets.dart';

import '../model/Defect.dart';
import '../model/DefectModel.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    return BlocConsumer<DefectModel, Defect>(
      builder: (context, state) {
        var model = context.read<DefectModel>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Дефект'),
            actions: [
              IconButton(
                tooltip: 'Добавить фото',
                icon: Icon(Icons.photo_library, size: 35),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Сфотографировать',
                icon: Icon(Icons.photo_camera, size: 35),
                onPressed: () {},
              ),
              Container(width: 15),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
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
        );
      },
      listener: (context, state) {},
    );
  }
}
