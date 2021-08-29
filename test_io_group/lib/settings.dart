import 'package:flutter/material.dart';

final h1 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final h2 = TextStyle(fontWeight: FontWeight.bold);

final vspacer = SizedBox(height: 10);
final hspacer = SizedBox(width: 15);

final appBar = AppBar(
  backgroundColor: Colors.white,
  leading: Icon(Icons.school, color: Colors.black),
  title: Text('Гимназио', style: TextStyle(color: Colors.black)),
);
