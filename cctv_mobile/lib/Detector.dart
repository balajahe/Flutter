import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

class Detector {
  final objectDetector =
      GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(classifyObjects: true, trackMutipleObjects: false));

  Future<void> detect(CameraImage img) async {
    final WriteBuffer buf = WriteBuffer();
    for (Plane plane in img.planes) {
      buf.putUint8List(plane.bytes);
    }
    final bytes = buf.done().buffer.asUint8List();

    final input = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: InputImageData(
          inputImageFormat: InputImageFormatMethods.fromRawValue(img.format.raw) ?? InputImageFormat.NV21,
          size: Size(img.width.toDouble(), img.height.toDouble()),
          planeData: null,
          imageRotation: InputImageRotation.Rotation_0deg,
        ));
    final output = await objectDetector.processImage(input);

    output.forEach((obj) {
      print(obj.getLabels().map((l) => l.getText()).join('\n'));
    });
  }
}
