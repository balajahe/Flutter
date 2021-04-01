import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as il;
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';

const _period = Duration(milliseconds: 200);

class DetectorState {
  List<int> image;
  DetectorState([this.image]);
}

class DetectorBloc extends Cubit<DetectorState> {
  CameraController _camera;
  DateTime _time = DateTime.now();
  bool _detecting = false;

  DetectorBloc(this._camera) : super(DetectorState());

  void start() {
    _camera.startImageStream((cimg) async {
      if (!_detecting && DateTimeRange(start: _time, end: DateTime.now()).duration > _period) {
        _detecting = true;
        emit(DetectorState(await compute(_decodeFromYuv420, cimg)));
        _time = DateTime.now();
        _detecting = false;
      }
    });
  }
}

List<int> _decodeFromYuv420(CameraImage cimg) {
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

  return il.PngEncoder(level: 0, filter: 0).encodeImage(img);
}
