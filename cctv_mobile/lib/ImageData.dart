import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';

class ImageData {
  final Uint8List dto; // черно-белые данные (LUMA) + 4 байта ширина/высота
  Uint8List _bgra; // пиксели RGBA
  final int width;
  final int height;

  ImageData(this.dto, this.width, this.height);

  factory ImageData.blank() {
    return ImageData(Uint8List(0), 0, 0);
  }

  Uint8List get bgra {
    if (_bgra == null) {
      _bgra = Uint8List(width * height * 4);
      for (int y = 0; y < height * width; y += width) {
        for (int x = 0; x < width; x++) {
          final luma = dto[y + x];
          final xy = (y + x) * 4;
          _bgra
            ..[xy] = luma
            ..[xy + 1] = luma
            ..[xy + 2] = luma
            ..[xy + 3] = 0xFF;
        }
      }
    }
    return _bgra;
  }

  factory ImageData.fromDto(Uint8List dto) {
    if (dto != null && dto.length > 4) {
      final sizeBuf = dto.buffer.asByteData(dto.length - 4);
      return (ImageData(dto, sizeBuf.getInt16(0), sizeBuf.getInt16(2)));
    } else {
      return ImageData.blank();
    }
  }

  factory ImageData.fromCamera(CameraImage img, {bool onlyDto = true}) {
    if (img.format.group == ImageFormatGroup.yuv420) {
      final dto = Uint8List(img.width * img.height + 4);
      final bw = img.planes[0].bytes;
      print('${img.width} * ${img.height} = ${img.width * img.height} / ${bw.length}');

      for (int i = 0; i < bw.length; i++) {
        dto[i] = bw[i];
      }

      final sizeBuf = dto.buffer.asByteData(dto.length - 4);
      sizeBuf.setInt16(0, img.width);
      sizeBuf.setInt16(2, img.height);

      return ImageData(dto, img.width, img.height);
    } else if (img.format.group == ImageFormatGroup.bgra8888) {
      return ImageData.blank();
    } else {
      return ImageData.blank();
    }
  }

  Future<ui.Image> toUiImage() async {
    final completer = new Completer<ui.Image>();
    ui.decodeImageFromPixels(
      this.bgra,
      this.width,
      this.height,
      ui.PixelFormat.bgra8888,
      (img) => completer.complete(img),
    );
    return completer.future;
  }
}
