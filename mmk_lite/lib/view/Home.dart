import 'package:flutter/material.dart';

import 'DefectAdd.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabSelected = 0;

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
      //body: ,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Новое дело',
            icon: Icon(Icons.library_add),
          ),
          BottomNavigationBarItem(
            label: 'Претензии',
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            label: 'Настройки',
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: tabSelected,
        onTap: (i) => setState(
          () => tabSelected = i,
        ),
      ),
    );
  }
}
