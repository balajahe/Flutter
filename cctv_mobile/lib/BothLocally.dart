import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorder.dart';

final _serverPort = 8181;

class BothLocally extends StatelessWidget {
  @override
  build(context) {
    return Column(
      children: [
        Expanded(
          child: Camera('127.0.0.1', _serverPort),
        ),
        Expanded(
          child: Recorder(_serverPort),
        ),
      ],
    );
  }
}
