import 'package:flutter/material.dart';
import 'common_widgets.dart';
import 'Home.dart';

void main() {
  ErrorWidget.builder = (e) => ErrorScreen(e);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCTV Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
