import 'package:flutter/material.dart';

import '../dao/Item.dart';

class ItemView extends StatelessWidget {
  final Item item;

  ItemView(this.item);

  @override
  build(context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(200, 100, 100, 100),
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: TextStyle(fontSize: 18)),
              Container(
                  height: 12,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(color: Colors.grey)),
              Text(item.text, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
