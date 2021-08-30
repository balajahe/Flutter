import 'dart:io';
import 'package:flutter/material.dart';
import 'common_widgets.dart';
import 'Recorder.dart';

class Recorders extends StatefulWidget {
  final int _serverPort;

  Recorders(this._serverPort);

  @override
  createState() => _RecordersState();
}

class _RecordersState extends State<Recorders> {
  HttpServer _listener;
  List<Recorder> _recorders = [];

  @override
  initState() {
    super.initState();
    (() async {
      try {
        _listener = await HttpServer.bind(InternetAddress.anyIPv4, widget._serverPort);
        _listener.listen((req) async {
          setState(() => _recorders.add(Recorder(req, onDisconnect)));
        });
      } catch (e) {
        showErrorScreen(context, e);
      }
    })();
  }

  void onDisconnect(Recorder rec) {
    setState(() => _recorders.remove(rec));
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _recorders.length == 0 ? 'Waiting for cameras...' : 'Connected ${_recorders.length} cameras',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Wrap(spacing: 20, runSpacing: 20, children: _recorders),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    //_recorders.clear();
    _listener?.close();
    super.dispose();
  }
}
