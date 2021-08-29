import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'image_tools.dart';
import 'ImageViewer.dart';

const _dropFrames = 10;

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
  ImageDto _imageDto;
  bool _isConnecting = true;
  bool _isProcessing = false;
  int _droppedFrames = 0;
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
          _imageDto = camera2Dto(img);
          try {
            _socket?.add(_imageDto.bytes);
          } catch (e) {
            setState(() => _msg = e.toString());
          }
          _droppedFrames++;
          if (_droppedFrames == _dropFrames) {
            setState(() {});
            _droppedFrames = 0;
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
          ImageViewer(_imageDto),
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
