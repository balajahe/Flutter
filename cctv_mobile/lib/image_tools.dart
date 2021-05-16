import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageDto {
  final int width;
  final int height;
  final Uint8List pixels;
  ImageDto(this.width, this.height, this.pixels);
}

ImageDto camera2Dto(CameraImage img) {
  if (img.format.group == ImageFormatGroup.bgra8888) {
    return ImageDto(img.width, img.height, img.planes[0].bytes);
  } else if (img.format.group == ImageFormatGroup.yuv420) {
    final lumas = img.planes[0].bytes;
    final pixels = Uint8List(img.height * img.width * 4);
    var yy = 0;
    for (int y = 0; y < img.height; y++) {
      yy += img.width;
      for (int x = 0; x < img.width; x++) {
        final luma = lumas[yy + x];
        final xy = (yy + x) * 4;
        pixels
          ..[xy] = luma
          ..[xy + 1] = luma
          ..[xy + 2] = luma
          ..[xy + 3] = 0xFF;
      }
    }
    return ImageDto(img.width, img.height, pixels);
  } else {
    return ImageDto(0, 0, Uint8List(0));
  }
}

Future<ui.Image> dto2Image(ImageDto img) async {
  final completer = new Completer<ui.Image>();
  ui.decodeImageFromPixels(
    img.pixels,
    img.width,
    img.height,
    ui.PixelFormat.bgra8888,
    (img1) => completer.complete(img1),
  );
  return completer.future;
}
