import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'common_widgets.dart';

class PhoneDetect extends StatefulWidget {
  @override
  createState() => _PhoneDetectState();
}

class _PhoneDetectState extends State<PhoneDetect> {
  CameraController _camera;
  //ImageLabeler _labeler;
  Future<void> _initFuture;
  bool _do;
  Uint8List _img = Uint8List(0);

  @override
  void initState() {
    super.initState();

    //_labeler = FirebaseVision.instance.imageLabeler();

    _initFuture = (() async {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = CameraController((await availableCameras())[0], ResolutionPreset.max, enableAudio: false);
      await _camera.initialize();
      //_start();
    })();
  }

  Future<void> _start() async {
    _do = true;

    await _camera.startImageStream((img) {
      setState(() => _img = img.planes[0].bytes);
    });
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Наведите камеру на номер телефона', style: TextStyle(fontSize: 14)),
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Stack(
              children: [
                Center(child: CameraPreview(_camera)),
                Container(
                  width: 100,
                  height: 100,
                  child: (_img.length > 0) ? Image.memory(_img) : Container(),
                )
              ],
            );
          else if (snapshot.hasError)
            return ErrorScreen(snapshot.error);
          else
            return Waiting();
        },
      ),
    );
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }
}
