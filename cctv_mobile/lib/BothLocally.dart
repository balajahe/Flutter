import 'package:flutter/material.dart';
import 'Client.dart';
import 'Server.dart';

final int _port = 8181;

class BothLocally extends StatelessWidget {
  @override
  build(context) {
    return Column(
      children: [
        Expanded(
          child: Client('127.0.0.1', _port),
        ),
        Expanded(
          child: Server(_port),
        ),
      ],
    );
  }
}
