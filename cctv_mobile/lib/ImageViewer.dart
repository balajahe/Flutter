import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'image_tools.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List _imageBytes;

  ImageViewer(this._imageBytes);

  @override
  build(context) {
    if (_imageBytes != null) {
      return FutureBuilder(
        future: bytesToImage(_imageBytes),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final imageInfo = infoFromBytes(_imageBytes);
            return OrientationBuilder(builder: (context, orientation) {
              return (orientation == Orientation.portrait)
                  ? RotatedBox(
                      quarterTurns: 1,
                      child: SizedBox(
                        width: imageInfo.width.toDouble(),
                        height: imageInfo.height.toDouble(),
                        child: CustomPaint(painter: _ImagePainter(snapshot.data)),
                      ),
                    )
                  : SizedBox(
                      width: imageInfo.width.toDouble(),
                      height: imageInfo.height.toDouble(),
                      child: CustomPaint(painter: _ImagePainter(snapshot.data)),
                    );
            });
          } else {
            return Container();
          }
        },
      );
    } else {
      return Container();
    }
  }
}

class _ImagePainter extends CustomPainter {
  ui.Image img;

  _ImagePainter(this.img);

  @override
  paint(canvas, size) => canvas.drawImage(img, new Offset(0 * -img.width / 2, 0 * -img.height / 2), Paint());

  @override
  shouldRepaint(oldDelegate) => true;
}
