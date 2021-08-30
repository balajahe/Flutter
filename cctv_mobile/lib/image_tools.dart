import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageInfo {
  int width;
  int height;

  ImageInfo(this.width, this.height);
}

ImageInfo infoFromBytes(Uint8List bytes) {
  if (bytes != null && bytes.length >= 4) {
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    return ImageInfo(buf.getInt16(0), buf.getInt16(2));
  } else {
    return ImageInfo(0, 0);
  }
}

Uint8List cameraToBytes(CameraImage img) {
  if (img.format.group == ImageFormatGroup.yuv420) {
    final lumas = img.planes[0].bytes;

    final bytes = Uint8List(img.width * img.height * 4 + 4);
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    buf.setInt16(0, img.width);
    buf.setInt16(2, img.height);

    for (int y = 0; y < img.height * img.width; y += img.width) {
      for (int x = 0; x < img.width; x++) {
        final luma = lumas[y + x];
        final xy = (y + x) * 4;
        bytes
          ..[xy] = luma
          ..[xy + 1] = luma
          ..[xy + 2] = luma
          ..[xy + 3] = 0xFF;
      }
    }
    return bytes;
  } else if (img.format.group == ImageFormatGroup.bgra8888) {
    //var bytes = img.planes[0].bytes; //добавить размер в конец
    return Uint8List(0);
  } else {
    return Uint8List(0);
  }
}

Future<ui.Image> bytesToImage(Uint8List bytes) async {
  final imageInfo = infoFromBytes(bytes);
  final completer = new Completer<ui.Image>();
  ui.decodeImageFromPixels(
    bytes,
    imageInfo.width,
    imageInfo.height,
    ui.PixelFormat.bgra8888,
    (img1) => completer.complete(img1),
  );
  return completer.future;
}
