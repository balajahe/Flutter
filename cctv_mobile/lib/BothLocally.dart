import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';

final _serverPort = 8080;
final _dropFrames = 10;

class BothLocally extends StatelessWidget {
  @override
  build(context) {
    return Column(
      children: [
        Expanded(
          child: Recorders(_serverPort),
        ),
        Expanded(
          child: Camera('127.0.0.1', _serverPort, _dropFrames),
        ),
      ],
    );
  }
}
