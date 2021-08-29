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

  @override
  initState() {
    super.initState();
    (() async {
      try {
        _listener = await HttpServer.bind('127.0.0.1', widget._serverPort);
        _listener.listen((req) async {
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
      body: ImageViewer(_imageBytes),
    );
  }

  @override
  dispose() {
    _socket?.close();
    _listener?.close();
    super.dispose();
  }
}
