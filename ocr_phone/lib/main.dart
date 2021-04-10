import 'package:flutter/material.dart';

import 'DetectorView.dart';
import 'common_widgets.dart';

void main() {
  ErrorWidget.builder = (e) => ErrorScreen(e);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      title: 'OCR Dialer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetectorView(),
    );
  }
}
