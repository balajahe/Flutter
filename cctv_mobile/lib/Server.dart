import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';
import 'main.dart';

class Server extends StatefulWidget {
  final int _serverPort;

  Server(this._serverPort);

  @override
  createState() => _ServerState();
}

class _ServerState extends State<Server> {
  HttpServer _listener;
  WebSocket _client;
  Uint8List _imageBytes;

  @override
  initState() {
    super.initState();
    (() async {
      try {
        _listener = await HttpServer.bind('127.0.0.1', widget._serverPort);
        _listener.listen((req) async {
          try {
            _client = await WebSocketTransformer.upgrade(req);
            _client.listen((msg) {
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
    _client?.close();
    _listener?.close();
    super.dispose();
  }
}
