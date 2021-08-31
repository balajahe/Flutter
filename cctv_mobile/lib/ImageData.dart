import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageData {
  final Uint8List bytes;
  final int width;
  final int height;

  ImageData(this.bytes, this.width, this.height);

  factory ImageData.blank() {
    return ImageData(Uint8List(0), 0, 0);
  }

  factory ImageData.fromBytes(Uint8List bytes) {
    if (bytes != null && bytes.length > 4) {
      final buf = bytes.buffer.asByteData(bytes.length - 4);
      return ImageData(bytes, buf.getInt16(0), buf.getInt16(2));
    } else {
      return ImageData.blank();
    }
  }

  factory ImageData.fromCamera(CameraImage img) {
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
      return ImageData.fromBytes(bytes);
    } else if (img.format.group == ImageFormatGroup.bgra8888) {
      //var bytes = img.planes[0].bytes; //добавить размер в конец
      return ImageData.blank();
    } else {
      return ImageData.blank();
    }
  }

  Future<ui.Image> toUiImage() async {
    final completer = new Completer<ui.Image>();
    ui.decodeImageFromPixels(
      this.bytes,
      this.width,
      this.height,
      ui.PixelFormat.bgra8888,
      (img) => completer.complete(img),
    );
    return completer.future;
  }
}
