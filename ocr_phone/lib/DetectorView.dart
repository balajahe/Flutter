import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';

import 'DetectorBloc.dart';
import 'common_widgets.dart';

class DetectorView extends StatelessWidget {
  @override
  build(context) {
    return BlocProvider(
      create: (_) => DetectorBloc(),
      child: BlocBuilder<DetectorBloc, DetectorState>(
        builder: (context, state) {
          if (!state.loading && state.error == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Наведите камеру на номер телефона',
                    style: TextStyle(fontSize: 16)),
              ),
              body: Stack(
                children: [
                  Center(
                    child: CameraPreview(state.camera),
                  ),
                  (state.image != null)
                      ? Container(
                          width: 100,
                          height: 100,
                          child: Image.memory(state.image),
                        )
                      : Container(),
                ],
              ),
            );
          } else if (state.error != null) {
            return ErrorWidget(state.error);
          } else {
            return Waiting();
          }
        },
      ),
    );
  }
}
