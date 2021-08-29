import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';
import 'main.dart';

class Recorder extends StatefulWidget {
  final int _serverPort;

  Recorder(this._serverPort);

  @override
  createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  HttpServer _listener;
  WebSocket _socket;
  Uint8List _imageBytes;
  String _msg = '';

  @override
  initState() {
    super.initState();
    (() async {
      try {
        setState(() => _msg = 'Binding...');
        _listener = await HttpServer.bind('127.0.0.1', widget._serverPort);
        setState(() => _msg = 'Waiting cameras...');

        _listener.listen((req) async {
          setState(() => _msg = req.connectionInfo.remoteAddress.host);
          try {
            _socket = await WebSocketTransformer.upgrade(req);
            _socket.listen((msg) {
              setState(() => _imageBytes = msg);
            });
          } catch (e) {
            showErrorScreen(context, e);
          }
        });
      } catch (e) {
        showErrorScreen(context, e);
      }
    })();
  }

  @override
  build(context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageViewer(_imageBytes),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(_msg),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _socket?.close();
    _listener?.close();
    super.dispose();
  }
}
