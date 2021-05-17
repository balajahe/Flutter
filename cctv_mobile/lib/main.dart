import 'package:flutter/material.dart';
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

class ErrorScreen extends StatelessWidget {
  final dynamic error;
  ErrorScreen(this.error);
  @override
  build(context) => Scaffold(
        appBar: AppBar(title: Text('ERROR')),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: SelectableText(
              error.toString(),
              style: TextStyle(color: Colors.red[900]),
            ),
          ),
        ),
      );
}

showErrorScreen(BuildContext context, dynamic e) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => ErrorScreen(e)));
