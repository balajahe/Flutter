import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'ImageData.dart';

class ImageViewer extends StatelessWidget {
  final ImageData _imageData;

  ImageViewer(this._imageData);

  @override
  build(context) {
    if (_imageData != null) {
      return FutureBuilder(
        future: _imageData.toUiImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final uiImage = snapshot.data;
            return OrientationBuilder(builder: (context, orientation) {
              return (orientation == Orientation.portrait)
                  ? RotatedBox(
                      quarterTurns: 1,
                      child: CustomPaint(
                        painter: _ImagePainter(uiImage),
                        size: Size(
                          uiImage.width.toDouble(),
                          uiImage.height.toDouble(),
                        ),
                      ),
                    )
                  : CustomPaint(
                      painter: _ImagePainter(snapshot.data),
                      size: Size(
                        uiImage.width.toDouble(),
                        uiImage.height.toDouble(),
                      ),
                      // ),
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
  paint(canvas, size) => canvas.drawImage(img, new Offset(0, 0), Paint());

  @override
  shouldRepaint(oldDelegate) => true;
}
