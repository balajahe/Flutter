import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';
import 'ImageData.dart';

class Recorder extends StatefulWidget {
  final HttpRequest _request;
  final Function(Recorder) _onDisconnect;

  Recorder(this._request, this._onDisconnect);

  @override
  createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  WebSocket _socket;
  ImageData _imageData;
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
        _socket.listen(
          (bytes) {
            setState(() => _imageData = ImageData.fromBytes(bytes));
          },
          onError: (e) => setState(() => _msg = e.toString()),
          //onDone: () => widget._onDisconnect(widget),
        );
      } catch (e) {
        setState(() => _msg = e.toString());
      }
    })();
  }

  @override
  build(context) {
    return Container(
      width: 640,
      height: 640,
      child: Stack(
        children: [
          Center(
            child: FittedBox(
              child: ImageViewer(_imageData),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(_msg, style: TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _socket?.close();
    super.dispose();
  }
}
