import 'package:flutter/material.dart';
import 'Client.dart';
import 'Server.dart';

class Both extends StatelessWidget {
  final String _host;
  final int _port;

  Both(this._host, this._port);

  @override
  build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Client(_host + ':' + _port.toString()),
            //Server(_port),
          ],
        ),
      ),
    );
  }
}
