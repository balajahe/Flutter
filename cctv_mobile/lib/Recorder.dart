import 'dart:io';
import 'dart:typed_data';
import 'package:cctv_mobile/image_tools.dart';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';
import 'main.dart';

class Recorder extends StatefulWidget {
  final HttpRequest _request;

  Recorder(this._request);

  @override
  createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  WebSocket _socket;
  Uint8List _imageBytes;
  String _msg = '';

  @override
  initState() {
    super.initState();
    setState(() {
      final info = widget._request.connectionInfo;
      _msg = info.remoteAddress.address + ':' + info.remotePort.toString();
    });
    (() async {
      try {
        _socket = await WebSocketTransformer.upgrade(widget._request);
        _socket.listen((msg) {
          setState(() => _imageBytes = msg);
        });
      } catch (e) {
        showErrorScreen(context, e);
      }
    })();
  }

  @override
  build(context) {
    final imageInfo = infoFromBytes(_imageBytes);
    return SizedBox(
      width: imageInfo.width.toDouble() * 2,
      height: imageInfo.height.toDouble() * 2,
      child: FittedBox(
        child: Column(
          children: [
            ImageViewer(_imageBytes),
            Align(
              alignment: Alignment.center,
              child: Text(_msg),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    _socket?.close();
    super.dispose();
  }
}
