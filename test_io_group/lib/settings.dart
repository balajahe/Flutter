import 'package:flutter/material.dart';

final h1 = TextStyle(fontSize: 20);
final h2 = TextStyle(fontWeight: FontWeight.bold);

final vspacer = SizedBox(height: 10);
final hspacer = SizedBox(width: 15);

final appBar = AppBar(
  title: Row(children: [
    Icon(Icons.school),
    hspacer,
    Text('Гимназио'),
  ]),
);
