import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ImageData.dart';
import 'ImageViewer.dart';

class Camera extends StatefulWidget {
  final String _serverAddress;
  final int _serverPort;
  final int _cameraResolution;
  final int _dropFrames;

  Camera(this._serverAddress, this._serverPort, this._cameraResolution, this._dropFrames);

  @override
  createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _camera;
  WebSocket _socket;
  ImageData _imageData;
  bool _isConnected = false;
  int _droppedFrames = 0;
  String _msg = '';

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    (() async {
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.values[widget._cameraResolution],
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420, // только для Андроид!
      );
      await _camera.initialize();

      _camera.startImageStream((img) {
        _droppedFrames++;
        if (_droppedFrames > widget._dropFrames) {
          _droppedFrames = 0;
          _imageData = ImageData.fromCamera(img);
          try {
            _socket?.add(_imageData.bytes);
          } catch (e) {
            setState(() => _msg = e.toString());
          }
          setState(() {});
        }
      });

      while (!_isConnected) {
        try {
          var s = 'ws://${widget._serverAddress}:${widget._serverPort}';
          print('Connecting to... $s');
          setState(() => _msg = 'Connecting to... $s');
          _socket = await WebSocket.connect(s);
          setState(() => _msg = 'Connected to $s');
          _isConnected = true;
        } catch (e) {
          print(e);
          try {
            setState(() => _msg = e.toString());
            await Future.delayed(Duration(milliseconds: 7000));
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
          Center(
            child: FittedBox(
              // child: (_camera != null) ? CameraPreview(_camera) : Container(),
              child: (_camera != null) ? ImageViewer(_imageData) : Container(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(_msg, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _isConnected = true;
    _socket?.close();
    _camera?.stopImageStream();
    _camera?.dispose();
    super.dispose();
  }
}
