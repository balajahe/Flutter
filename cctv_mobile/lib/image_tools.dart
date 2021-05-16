import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageDto {
  final Uint8List bytes;
  final int width;
  final int height;

  ImageDto(this.bytes, this.width, this.height) {
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    buf.setInt8(0, width);
    buf.setInt8(2, height);
  }

  factory ImageDto.fromBytes(Uint8List bytes) {
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    return ImageDto(bytes, buf.getInt8(0), buf.getInt8(2));
  }
}

ImageDto camera2Dto(CameraImage img) {
  if (img.format.group == ImageFormatGroup.bgra8888) {
    return ImageDto(
      //исправить - размер нужно добавить в конец массива!
      img.planes[0].bytes,
      img.width,
      img.height,
    );
  } else if (img.format.group == ImageFormatGroup.yuv420) {
    final lumas = img.planes[0].bytes;
    final pixels = Uint8List(img.height * img.width * 4 + 4);
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
    return ImageDto(pixels, img.width, img.height);
  } else {
    return ImageDto(Uint8List(4), 0, 0);
  }
}

Future<ui.Image> dto2Image(ImageDto imageDto) async {
  final completer = new Completer<ui.Image>();
  ui.decodeImageFromPixels(
    imageDto.bytes,
    imageDto.width,
    imageDto.height,
    ui.PixelFormat.bgra8888,
    (img1) => completer.complete(img1),
  );
  return completer.future;
}
