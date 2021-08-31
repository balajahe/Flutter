import 'dart:io';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';
import 'ImageData.dart';

class Recorder extends StatefulWidget {
  final HttpRequest _request;
  final Function(Recorder) _onDisconnect;

  Recorder(this._request, this._onDisconnect) : super(key: UniqueKey());

  @override
  createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  WebSocket _socket;
  ImageData _imageData;
  String _title = '';
  String _msg = '';

  @override
  initState() {
    super.initState();
    setState(() {});
    (() async {
      try {
        final info = widget._request.connectionInfo;
        _title = info.remoteAddress.address + ':' + info.remotePort.toString();
        setState(() {});
        _socket = await WebSocketTransformer.upgrade(widget._request);
        _socket.listen(
          (bytes) {
            setState(() {
              _imageData = ImageData.fromDto(bytes);
              _msg = _title + ' / ' + DateTime.now().toIso8601String().substring(0, 19);
            });
          },
          onError: (e) => setState(() => _msg = e.toString()),
          //onDone: () => widget._onDisconnect(widget),
        );
      } catch (e) {
        _msg = _title + ' / ' + DateTime.now().toIso8601String().substring(0, 19) + '\n' + e.toString();
      }
    })();
  }

  @override
  build(context) {
    return Column(
      children: [
        Text(_msg),
        Container(
          width: 480,
          height: 640,
          child: FittedBox(
            child: ImageViewer(_imageData),
          ),
        ),
      ],
    );
  }

  @override
  dispose() {
    _socket?.close();
    super.dispose();
  }
}
