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
            Tab(icon: Icon(Icons.create)),
            Tab(icon: Icon(Icons.library_books)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
