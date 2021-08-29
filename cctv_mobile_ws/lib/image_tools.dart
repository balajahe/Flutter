import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageDto {
  final Uint8List bytes;
  final int width;
  final int height;

  ImageDto(this.bytes, this.width, this.height);

  factory ImageDto.fromBytes(Uint8List bytes) {
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    return ImageDto(
      bytes, //.buffer.asUint8List(0, bytes.length - 4), - опасно, но работает)
      buf.getInt16(0),
      buf.getInt16(2),
    );
  }
}

Uint8List camera2Bytes(CameraImage img) {
  if (img.format.group == ImageFormatGroup.bgra8888) {
    //исправить - размер нужно добавить в конец массива!
    return img.planes[0].bytes;
  } else if (img.format.group == ImageFormatGroup.yuv420) {
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
  } else {
    return null;
  }
}

Future<ui.Image> bytes2Image(Uint8List imageBytes) async {
  final imageDto = ImageDto.fromBytes(imageBytes);
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
