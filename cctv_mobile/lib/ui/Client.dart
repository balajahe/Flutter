import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

class Client extends StatefulWidget {
  @override
  createState() => _ClientState();
}

class _ClientState extends State<Client> {
  CameraController _camera;
  Uint8List _image;
  ui.Image _image1;
  bool _processing = false;

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    (() async {
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.bgra8888,
      );
      await _camera.initialize();
      setState(() {});

      _camera.startImageStream((img) async {
        if (!_processing) {
          _processing = true;
          //var img1 = await compute(_convertImage, img);
          // setState(() {
          //   _image = img1;
          // });
          var img1 = await _convertImage1(img);
          setState(() {
            _image1 = img1;
          });
          _processing = false;
        }
      });
    })();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: (_camera != null)
                ? CameraPreview(_camera)
                : Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            child: (_image1 != null)
                ? CustomPaint(painter: _ImageViever(_image1))
                : Center(child: CircularProgressIndicator()),
          ),
          // Expanded(
          //   child: (_image != null)
          //       ? Image.memory(_image)
          //       : Center(child: CircularProgressIndicator()),
          // ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _camera?.dispose();
    super.dispose();
  }
}

class _ImageViever extends CustomPainter {
  ui.Image image;

  _ImageViever(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Uint8List _convertImage(CameraImage img) {
  try {
    imglib.Image img1;
    if (img.format.group == ImageFormatGroup.bgra8888) {
      img1 = imglib.Image.fromBytes(
        img.width,
        img.height,
        img.planes[0].bytes,
        format: imglib.Format.bgra,
      );
    } else if (img.format.group == ImageFormatGroup.yuv420) {
      img1 = imglib.Image(img.width, img.height); // Create Image buffer

      Plane plane = img.planes[0];
      const int shift = (0xFF << 24);

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < img.width; x++) {
        for (int planeOffset = 0; planeOffset < img.height * img.width; planeOffset += img.width) {
          final pixelColor = plane.bytes[planeOffset + x];
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          // Calculate pixel color
          var newVal = shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

          img1.data[planeOffset + x] = newVal;
        }
      }
    }
    imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
    return pngEncoder.encodeImage(img1);
  } catch (e) {
    print(">>>>>>>>>>>> ERROR:" + e.toString());
    return null;
  }
}

Future<ui.Image> _convertImage1(CameraImage img) async {
  final Completer<ui.Image> completer = new Completer();
  ui.decodeImageFromPixels(
    img.planes[0].bytes,
    img.width,
    img.height,
    ui.PixelFormat.bgra8888,
    (img) => completer.complete(img),
  );
  return completer.future;
}
