import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as il;
import 'package:tflite_flutter/tflite_flutter.dart' as tf;

const _period = Duration(milliseconds: 200);

class DetectorState {
  bool loading = false;
  String error;
  CameraController camera;
  List<int> image;
  DetectorState([this.camera, this.image]);
}

class DetectorBloc extends Cubit<DetectorState> {
  CameraController _camera;
  tf.Interpreter _interpreter;
  DateTime _time = DateTime.now();
  bool _detecting = false;

  DetectorBloc() : super(DetectorState()..loading = true) {
    _load();
  }

  Future<void> _load() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _camera.initialize();

      _interpreter =
          await tf.Interpreter.fromAsset('lite-model_rosetta_float16_1.tflite');

      _camera.startImageStream(_detect);
      emit(DetectorState(_camera));
    } catch (e) {
      emit(DetectorState()..error = e);
    }
  }

  Future<void> _detect(CameraImage cimg) async {
    if (!_detecting &&
        DateTimeRange(start: _time, end: DateTime.now()).duration > _period) {
      _detecting = true;
      emit(DetectorState(_camera, await compute(_decodeFromYuv420, cimg)));
      _time = DateTime.now();
      _detecting = false;
    }
  }

  @override
  Future<void> close() async {
    await _camera?.stopImageStream();
    await _camera?.dispose();
    _interpreter?.close();
    super.close();
  }
}

List<int> _decodeFromYuv420(CameraImage cimg) {
  var img = il.Image(cimg.width, cimg.height); // Create Image buffer

  Plane plane = cimg.planes[0];
  const int shift = (0xFF << 24);

  // Fill image buffer with plane[0] from YUV420_888
  for (int x = 0; x < cimg.width; x++) {
    for (int planeOffset = 0;
        planeOffset < cimg.height * cimg.width;
        planeOffset += cimg.width) {
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
