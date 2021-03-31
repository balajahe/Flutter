import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as il;
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
  List<int> _img;

  @override
  void initState() {
    super.initState();

    //_labeler = FirebaseVision.instance.imageLabeler();

    _initFuture = (() async {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _camera.initialize();
      _start();
    })();
  }

  void _start() {
    var i = 0;
    _camera.startImageStream((cimg) {
      i++;
      if (i == 100) {
        setState(() => _img = _decodeImg(cimg));
        i = 0;
      }
    });
  }

  List<int> _decodeImg(CameraImage cimg) {
    var img = il.Image(cimg.width, cimg.height); // Create Image buffer

    Plane plane = cimg.planes[0];
    const int shift = (0xFF << 24);

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < cimg.width; x++) {
      for (int planeOffset = 0; planeOffset < cimg.height * cimg.width; planeOffset += cimg.width) {
        final pixelColor = plane.bytes[planeOffset + x];
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        // Calculate pixel color
        var newVal = shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

        img.data[planeOffset + x] = newVal;
      }
    }
    var pngEncoder = new il.PngEncoder(level: 0, filter: 0);
    return pngEncoder.encodeImage(img);
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
            return Column(
              children: [
                Expanded(child: CameraPreview(_camera)),
                Expanded(child: (_img != null) ? Image.memory(_img) : Container()),
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
