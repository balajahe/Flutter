import 'package:flutter/material.dart';

import '../dao/Item.dart';

class ItemView extends StatelessWidget {
  final Item item;

  ItemView(this.item);

  @override
  build(context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 100, 100, 100),
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: TextStyle(fontSize: 18)),
                  Container(
                      height: 8,
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Container(color: Colors.grey)),
                  Text(item.text, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
