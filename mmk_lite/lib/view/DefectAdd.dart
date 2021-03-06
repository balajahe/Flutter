import 'package:flutter/material.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Дефект'),
        actions: [
          IconButton(
            tooltip: 'Добавить дефект',
            icon: Icon(Icons.add, size: 40),
            onPressed: () {},
          ),
          Container(width: 15),
        ],
      ),
    );
  }
}
