import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class Viewer extends StatelessWidget {
  final ui.Image _img;
  Viewer(this._img);

  @override
  build(context) {
    return Center(
      child: (_img != null)
          ? OrientationBuilder(builder: (context, orientation) {
              return (orientation == Orientation.portrait)
                  ? RotatedBox(
                      quarterTurns: 1,
                      child: CustomPaint(painter: _ImageViewer(_img)),
                    )
                  : CustomPaint(painter: _ImageViewer(_img));
            })
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class _ImageViewer extends CustomPainter {
  ui.Image img;
  _ImageViewer(this.img);

  @override
  paint(canvas, size) {
    canvas.drawImage(img, new Offset(-img.width / 2, -img.height / 2), Paint());
  }

  @override
  shouldRepaint(oldDelegate) => true;
}
