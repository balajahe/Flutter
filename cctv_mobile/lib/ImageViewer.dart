import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'image_tools.dart';

class ImageViewer extends StatelessWidget {
  final ImageDto _imageDto;
  ImageViewer(this._imageDto);

  @override
  build(context) {
    return Center(
      child: FutureBuilder(
        future: dto2Image(_imageDto),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return OrientationBuilder(builder: (context, orientation) {
              return (orientation == Orientation.portrait)
                  ? RotatedBox(
                      quarterTurns: 1,
                      child: CustomPaint(painter: _ImagePainter(snapshot.data)),
                    )
                  : CustomPaint(painter: _ImagePainter(snapshot.data));
            });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _ImagePainter extends CustomPainter {
  ui.Image img;
  _ImagePainter(this.img);

  @override
  paint(canvas, size) =>
      canvas.drawImage(img, new Offset(-img.width / 2, -img.height / 2), Paint());

  @override
  shouldRepaint(oldDelegate) => true;
}
