import 'package:flutter/material.dart';

import 'DetectUi.dart';
import 'common_widgets.dart';

void main() {
  ErrorWidget.builder = (e) => ErrorScreen(e);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      title: 'OCR Dial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetectUi(),
    );
  }
}
