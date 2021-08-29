import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'image_tools.dart';
import 'ImageViewer.dart';

class Camera extends StatefulWidget {
  final String serverAddress;
  final int serverPort;

  Camera(this.serverAddress, this.serverPort);

  @override
  createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _camera;
  WebSocket _socket;
  Uint8List _imageBytes;
  bool _isConnecting = true;
  bool _isProcessing = false;
  String _msg = '';

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    (() async {
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.low,
      );
      await _camera.initialize();

      _camera.startImageStream((img) async {
        if (!_isProcessing) {
          _isProcessing = true;
          _imageBytes = camera2Bytes(img);
          try {
            setState(() {});
            _socket?.add(_imageBytes);
          } catch (e) {
            setState(() => _msg = e.toString());
          }
          _isProcessing = false;
        }
      });

      while (_isConnecting) {
        try {
          var s = 'ws://${widget.serverAddress}:${widget.serverPort}';
          print('Connecting to... $s');
          setState(() => _msg = 'Connecting to... $s');
          _socket = await WebSocket.connect(s);
          setState(() => _msg = 'Connected to $s');
          _isConnecting = false;
        } catch (e) {
          print(e);
          try {
            setState(() => _msg = e.toString());
            await Future.delayed(Duration(milliseconds: 10000));
          } catch (_) {}
        }
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
    _isConnecting = false;
    _socket?.close();
    _camera?.stopImageStream();
    _camera?.dispose();
    super.dispose();
  }
}
