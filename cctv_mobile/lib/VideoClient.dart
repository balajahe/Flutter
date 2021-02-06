import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

const SRV_ADDR = '192.168.43.196:4040';

class VideoClientPage extends StatelessWidget {
  @override build(context) => Scaffold(
    appBar: AppBar(title: Text('Camera')),
    body: VideoClientWidget(),
  );
}

class VideoClientWidget extends StatefulWidget {
  final String srvAddr;
  VideoClientWidget([this.srvAddr = SRV_ADDR]);
  @override createState() => _State();
} 

class _State extends State<VideoClientWidget> {
  TextEditingController _srvAddr;
  CameraController _camera;
  WebSocket _socket;
  String _dir;
  Exception _err;
  bool _recording = false;
  int _recorded = 0;

  @override initState() {
    super.initState();
    () async {
      try {
        _dir = (await getTemporaryDirectory()).path;
        _srvAddr = TextEditingController(text: widget.srvAddr);
        final cams = await availableCameras();
        print('-------\n $cams \n $_dir \n-------');
        _camera = CameraController(cams[0], ResolutionPreset.medium);
        await _camera.initialize();
        setState((){});
      } catch(e) { setState(() => _err = e); }
    }();
  }

  _startRec() async { 
    try {
      _recorded++;
      await _camera.startVideoRecording('$_dir/_$_recorded.mp4');
      try { await File('$_dir/_${_recorded+1}.mp4').delete(); } catch(_){}
      setState((){});
      Timer(Duration(seconds: 3), () {
        if (_recording && _err == null) _stopRec(again: true);
      });
    } catch(e) { setState(() => _err = e); }
  }

  _stopRec({@required bool again}) async { 
    try {
      await _camera.stopVideoRecording();
      final fname = '$_dir/_$_recorded.mp4';
      if (again) await _startRec();
      _socket.add(await File(fname).readAsBytes());
      await File(fname).delete();
    } catch(e) { setState(() => _err = e); }
  }

  _startStopRec() async {
    try {
      _recording = !_recording;
      setState(() =>_err = null);
      if (_recording) {
        _socket = await WebSocket.connect('ws://' + _srvAddr.text);
        try { File('$_dir/_1.mp4').deleteSync(); } catch(_){}
        await _startRec();
      } else {
        _recording = false;
        await _stopRec(again: false);
        await _socket.close();
        _socket = null;
        setState((){});
      }
    } catch(e) { setState(() => _err = e); }
  }

  @override dispose() {
    _recording = false;
    try { _socket.close(); } catch(_){}
    _camera.dispose();
    super.dispose();
  }

  @override build(context) {
    if (_err != null) return Center(child: Text(_err.toString()));
    if (_camera?.value == null) return Center(child: Text('Activating camera...'));
    return Scaffold(
      body: Column(children: [
        Row(children: [
          Text(' Server: '),
          Expanded(child: TextFormField(
            controller: _srvAddr,
            decoration: InputDecoration(hintText: 'IP:port'),
            //autofocus: true,
          )),
          Text(_socket != null ? '$_recorded.mp4' : _recording ? 'connecting...' : ''),
        ]),
        Expanded(child: AspectRatio(
          aspectRatio: _camera.value.aspectRatio,
          child: CameraPreview(_camera)
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_recording ? 'STOP' : 'START'),
        backgroundColor: _recording ? Colors.red : null,
        onPressed: _startStopRec,
      ),
    );
  }
}
