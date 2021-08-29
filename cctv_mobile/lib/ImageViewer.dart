import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'image_tools.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List _imageBytes;
  ImageViewer(this._imageBytes);

  @override
  build(context) {
    return Center(
      child: (_imageBytes != null)
          ? FutureBuilder(
              future: bytes2Image(_imageBytes),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return OrientationBuilder(builder: (context, orientation) {
                    return (orientation == Orientation.portrait)
                        ? RotatedBox(
                            quarterTurns: 1,
                            child: CustomPaint(
                                painter: _ImagePainter(snapshot.data)),
                          )
                        : CustomPaint(painter: _ImagePainter(snapshot.data));
                  });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          : CircularProgressIndicator(),
    );
  }
}

class _ImagePainter extends CustomPainter {
  ui.Image img;
  _ImagePainter(this.img);

  @override
  paint(canvas, size) => canvas.drawImage(
      img, new Offset(-img.width / 2, -img.height / 2), Paint());

  @override
  shouldRepaint(oldDelegate) => true;
}
