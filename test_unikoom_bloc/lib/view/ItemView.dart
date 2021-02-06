import 'package:flutter/cupertino.dart';
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: TextStyle(fontSize: 18)),
                    Container(height: 5),
                    Text(item.text, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
