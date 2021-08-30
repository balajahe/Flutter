import 'dart:io';
import 'dart:typed_data';
import 'package:cctv_mobile/image_tools.dart';
import 'package:flutter/material.dart';
import 'ImageViewer.dart';

class Recorder extends StatefulWidget {
  final HttpRequest _request;
  final Function(Recorder) _onDisconnect;

  Recorder(this._request, this._onDisconnect);

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
        _socket.listen(
          (msg) {
            setState(() => _imageBytes = msg);
          },
          onError: (e) => setState(() => _msg = e.toString()),
          onDone: () => widget._onDisconnect(widget),
        );
      } catch (e) {
        setState(() => _msg = e.toString());
      }
    })();
  }

  @override
  build(context) {
    //final imageInfo = infoFromBytes(_imageBytes);
    return SizedBox(
      width: 640,
      height: 640,
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
