import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Client extends StatefulWidget {
  @override
  createState() => _ClientState();
}

class _ClientState extends State<Client> {
  CameraController _camera;
  Uint8List _arr;
  ui.Image _image;
  bool _processing = false;

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
      setState(() {});

      _camera.startImageStream((img) async {
        if (!_processing) {
          _processing = true;
          var img1 = await _convertImage(img);
          setState(() => _image = img1);
          _processing = false;
        }
      });
    })();
  }

  @override
  build(context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text('Camera'),
        //   ),
        //   body:
        //Center(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //child:
        // Expanded(
        //   child: (_camera != null)
        //       ? CameraPreview(_camera)
        //       : Center(child: CircularProgressIndicator()),
        // ),
        //Expanded(
        (_image != null)
            ? CustomPaint(painter: _ImageViewer(_image))
            : Center(child: CircularProgressIndicator());
  }

  @override
  dispose() {
    _camera?.dispose();
    super.dispose();
  }

  Future<ui.Image> _convertImage(CameraImage img) async {
    final completer = new Completer<ui.Image>();
    if (img.format.group == ImageFormatGroup.bgra8888) {
      ui.decodeImageFromPixels(
        img.planes[0].bytes,
        img.width,
        img.height,
        ui.PixelFormat.bgra8888,
        (img) => completer.complete(img),
      );
    } else if (img.format.group == ImageFormatGroup.yuv420) {
      if (_arr == null) {
        _arr = Uint8List(img.height * img.width * 4);
      }
      final lumas = img.planes[0].bytes;
      var width = img.width;
      var height = img.height;

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final luma = lumas[y * height + x];
          final i = (y * height + x) * 4;
          // final y1 = x;
          // final x1 = img.height - y;
          // final i = (y1 * img.width + x1) * 4;
          _arr[i] = luma;
          _arr[i + 1] = luma;
          _arr[i + 2] = luma;
          _arr[i + 3] = 0xFF;
        }
      }
      ui.decodeImageFromPixels(
        _arr,
        width,
        height,
        ui.PixelFormat.bgra8888,
        (img) => completer.complete(img),
      );
    }
    return completer.future;
  }
}

class _ImageViewer extends CustomPainter {
  ui.Image img;
  _ImageViewer(this.img);

  @override
  paint(Canvas canvas, Size size) {
    canvas.drawImage(img, new Offset(0, 0), Paint());
  }

  @override
  shouldRepaint(CustomPainter oldDelegate) => true;
}

// Uint8List _convertImage1(CameraImage img) {
//   try {
//     imglib.Image img1;
//     if (img.format.group == ImageFormatGroup.bgra8888) {
//       img1 = imglib.Image.fromBytes(
//         img.width,
//         img.height,
//         img.planes[0].bytes,
//         format: imglib.Format.bgra,
//       );
//     } else if (img.format.group == ImageFormatGroup.yuv420) {
//       img1 = imglib.Image(img.width, img.height); // Create Image buffer

//       Plane plane = img.planes[0];
//       const int shift = (0xFF << 24);

//       // Fill image buffer with plane[0] from YUV420_888
//       for (int x = 0; x < img.width; x++) {
//         for (int planeOffset = 0; planeOffset < img.height * img.width; planeOffset += img.width) {
//           final pixelColor = plane.bytes[planeOffset + x];
//           // color: 0x FF  FF  FF  FF
//           //           A   B   G   R
//           // Calculate pixel color
//           var newVal = shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

//           img1.data[planeOffset + x] = newVal;
//         }
//       }
//     }
//     imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
//     return pngEncoder.encodeImage(img1);
//   } catch (e) {
//     print(">>>>>>>>>>>> ERROR:" + e.toString());
//     return null;
//   }
// }
