import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';

const _serverPort = 8080;

class BothLocally extends StatelessWidget {
  @override
  build(context) {
    return Column(
      children: [
        Expanded(
          child: Recorders(_serverPort),
        ),
        Expanded(
          child: Camera('127.0.0.1', _serverPort),
        ),
      ],
    );
  }
}
