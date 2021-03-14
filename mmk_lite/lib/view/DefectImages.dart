import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectModel.dart';

class DefectImages extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<DefectModel, DefectState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Изображения')),
          body: ListView(
            children: state.data.images
                .map(
                  (v) => Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                    child: Image.memory(v),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
