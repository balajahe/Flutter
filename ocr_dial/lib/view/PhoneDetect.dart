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

  @override
  void initState() {
    super.initState();

    //_labeler = FirebaseVision.instance.imageLabeler();

    _initFuture = (() async {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = CameraController((await availableCameras())[0], ResolutionPreset.max, enableAudio: false);
      await _camera.initialize();
    })();
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
            return (snapshot.connectionState == ConnectionState.done)
                ? Center(child: CameraPreview(_camera))
                : (snapshot.hasError)
                    ? ErrorScreen(snapshot.error)
                    : Waiting();
          }),
    );
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }
}
