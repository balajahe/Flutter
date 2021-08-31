import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';

class BothLocally extends StatelessWidget {
  final int _serverPort;
  final int _cameraResolution;
  final int _dropFrames;

  BothLocally(this._serverPort, this._cameraResolution, this._dropFrames);

  @override
  build(context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Recorders(_serverPort),
          ),
          Container(height: 5),
          Expanded(
            flex: 2,
            child: Camera('127.0.0.1', _serverPort, _cameraResolution, _dropFrames),
          ),
        ],
      ),
    );
  }
}
