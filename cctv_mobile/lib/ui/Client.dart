import 'dart:typed_data';
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
  bool _processing = false;

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    (() async {
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.high,
        //imageFormatGroup: ImageFormatGroup.bgra8888,
      );
      await _camera.initialize();
      setState(() {});

      _camera.startImageStream((img) async {
        if (!_processing) {
          _processing = true;
          var img1 = await compute(_convertImage, img);
          setState(() {
            _image = img1;
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
            child: (_image != null)
                ? Image.memory(_image)
                : Center(child: CircularProgressIndicator()),
          ),
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
        for (int planeOffset = 0;
            planeOffset < img.height * img.width;
            planeOffset += img.width) {
          final pixelColor = plane.bytes[planeOffset + x];
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          // Calculate pixel color
          var newVal =
              shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

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
