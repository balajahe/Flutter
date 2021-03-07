import 'package:flutter/material.dart';

import 'DefectAdd.dart';

class Issue extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.question_answer),
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
      body: Center(child: Text('Нажмите "+" чтобы добавить дефект в дело')),
    );
  }
}
