import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'image_tools.dart';

class ImageViewer extends StatelessWidget {
  final ImageDto _imageDto;

  ImageViewer(this._imageDto);

  @override
  build(context) {
    if (_imageDto != null) {
      return FutureBuilder(
        future: dto2Image(_imageDto),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OrientationBuilder(builder: (context, orientation) {
              return (orientation == Orientation.portrait)
                  ? RotatedBox(
                      quarterTurns: 1,
                      child: SizedBox(
                        width: _imageDto.width.toDouble(),
                        height: _imageDto.height.toDouble(),
                        child: CustomPaint(painter: _ImagePainter(snapshot.data)),
                      ),
                    )
                  : SizedBox(
                      width: _imageDto.width.toDouble(),
                      height: _imageDto.height.toDouble(),
                      child: CustomPaint(painter: _ImagePainter(snapshot.data)),
                    );
            });
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    } else {
      return CircularProgressIndicator();
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
