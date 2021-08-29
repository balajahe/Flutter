import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'lib/common_widgets.dart';

class DefectBarcodeScan extends StatefulWidget {
  @override
  createState() => _DefectBarcodeScanState();
}

class _DefectBarcodeScanState extends State<DefectBarcodeScan> {
  CameraController _controller;
  Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = (() async {
      WidgetsFlutterBinding.ensureInitialized();
      var cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.max);
      await _controller.initialize();
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сканирование...'),
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done)
            ? CameraPreview(_controller)
            : (snapshot.hasError)
                ? ErrorScreen(snapshot.error)
                : Waiting(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
