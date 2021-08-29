import 'dart:io';
import 'package:flutter/material.dart';
import 'image_tools.dart';
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
  ImageDto _imageDto;
  String _msg = '';

  @override
  initState() {
    super.initState();
    (() async {
      try {
        setState(() => _msg = 'Binding...');
        _listener = await HttpServer.bind(InternetAddress.anyIPv4, widget._serverPort);
        setState(() => _msg = 'Waiting for cameras...');

        _listener.listen((req) async {
          setState(
              () => _msg = req.connectionInfo.remoteAddress.address + ':' + req.connectionInfo.remotePort.toString());
          try {
            _socket = await WebSocketTransformer.upgrade(req);
            _socket.listen((msg) {
              setState(() => _imageDto = ImageDto.fromBytes(msg));
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
      appBar: AppBar(),
      body: Wrap(
        children: [
          ImageViewer(_imageDto),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Text(_msg),
          // ),
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
