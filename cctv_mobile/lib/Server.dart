import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ImageViewer.dart';

class Server extends StatefulWidget {
  @override
  createState() => _ServerState();
}

class _ServerState extends State<Server> {
  HttpServer _listener;
  WebSocket _client;

  @override
  initState() {
    super.initState();
    (() async {
      _listener = await HttpServer.bind('127.0.0.1', 4040);
      _listener.listen((req) async {
        _client = await WebSocketTransformer.upgrade(req);
        _client.listen((msg) {
          print(msg);
        });
      });
    })();
  }

  @override
  build(context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
