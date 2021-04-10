import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';

import 'DetectorBloc.dart';
import 'common_widgets.dart';

class DetectorView extends StatefulWidget {
  @override
  createState() => _DetectorViewState();
}

class _DetectorViewState extends State<DetectorView> {
  CameraController _camera;
  Future<void> _initFuture;
  DetectorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _initFuture = (() async {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = CameraController(
        (await availableCameras())[0],
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _camera.initialize();
      _bloc = DetectorBloc(_camera);
      _bloc.start();
    })();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Наведите камеру на номер телефона', style: TextStyle(fontSize: 14)),
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Center(
                  child: CameraPreview(_camera),
                ),
                BlocBuilder<DetectorBloc, DetectorState>(
                    bloc: _bloc,
                    builder: (context, state) {
                      return (state.image != null)
                          ? Container(
                              width: 100,
                              height: 100,
                              child: Image.memory(state.image),
                            )
                          : Container();
                    })
              ],
            );
          } else if (snapshot.hasError)
            return ErrorScreen(snapshot.error);
          else
            return Waiting();
        },
      ),
    );
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }
}
