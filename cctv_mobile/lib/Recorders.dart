import 'dart:io';
import 'package:flutter/material.dart';
import 'Recorder.dart';
import 'main.dart';

class Recorders extends StatefulWidget {
  final int _serverPort;

  Recorders(this._serverPort);

  @override
  createState() => _RecordersState();
}

class _RecordersState extends State<Recorders> {
  HttpServer _listener;
  List<Recorder> _recorders = [];
  String _msg = '';

  @override
  initState() {
    super.initState();
    (() async {
      try {
        setState(() => _msg = 'Binding...');
        _listener = await HttpServer.bind(InternetAddress.anyIPv4, widget._serverPort);
        _listener.listen((req) async {
          setState(() => _recorders.add(Recorder(req)));
        });
      } catch (e) {
        showErrorScreen(context, e);
      }
    })();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _recorders.length == 0 ? 'Waiting for cameras...' : 'Connected ${_recorders.length} cams',
        ),
      ),
      body: Center(
        child: Wrap(runSpacing: 30, children: _recorders),
      ),
    );
  }

  @override
  dispose() {
    _recorders.clear();
    _listener?.close();
    super.dispose();
  }
}
