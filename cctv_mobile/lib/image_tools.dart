import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageDto {
  final Uint8List bytes;
  final int width;
  final int height;

  ImageDto(this.bytes, this.width, this.height);

  factory ImageDto.blank() => ImageDto(Uint8List(0), 0, 0);

  factory ImageDto.fromBytes(Uint8List bytes) {
    if (bytes == null || bytes.length == 0) {
      return ImageDto.blank();
    }
    final buf = bytes.buffer.asByteData(bytes.length - 4);
    return ImageDto(
      bytes, //хвостовые байты остались, опасно, но пока работает...
      buf.getInt16(0),
      buf.getInt16(2),
    );
  }
}

ImageDto camera2Dto(CameraImage img) {
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
    return ImageDto.fromBytes(bytes);
  } else if (img.format.group == ImageFormatGroup.bgra8888) {
    return null; //img.planes[0].bytes; //доделать - добавить размер в конец массива!
  } else {
    return null;
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
