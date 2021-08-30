import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'image_tools.dart';
import 'ImageViewer.dart';

final _resolution = ResolutionPreset.values[2];

class Camera extends StatefulWidget {
  final String serverAddress;
  final int serverPort;
  final int _dropFrames;

  Camera(this.serverAddress, this.serverPort, this._dropFrames);

  @override
  createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _camera;
  WebSocket _socket;
  Uint8List _imageBytes;
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
        _resolution,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420, // только для Андроид!
      );
      await _camera.initialize();

      _camera.startImageStream((img) {
        _droppedFrames++;
        if (_droppedFrames == widget._dropFrames) {
          _droppedFrames = 0;
          _imageBytes = cameraToBytes(img);
          try {
            _socket?.add(_imageBytes);
          } catch (e) {
            setState(() => _msg = e.toString());
          }
          setState(() {});
        }
      });

      while (!_isConnected) {
        try {
          var s = 'ws://${widget.serverAddress}:${widget.serverPort}';
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
            child: ImageViewer(_imageBytes),
          ),
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
    _isConnected = true;
    _socket?.close();
    _camera?.stopImageStream();
    _camera?.dispose();
    super.dispose();
  }
}
