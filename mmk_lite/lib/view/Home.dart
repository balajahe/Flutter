import 'package:flutter/material.dart';

import 'IssueAdd.dart';

class Home extends StatelessWidget {
  @override
  build(context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            IssueAdd(),
            Container(),
            Container(),
          ],
        ),
        bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          tabs: [
            Tab(
              child: Text('Новая', style: TextStyle(fontSize: 11)),
              icon: Icon(Icons.create),
            ),
            Tab(
              child: Text('Претензии', style: TextStyle(fontSize: 11)),
              icon: Icon(Icons.library_books),
            ),
            Tab(
              child: Text('Настройки', style: TextStyle(fontSize: 11)),
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
