import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

const SRV_PORT = 4040;

class VideoServerPage extends StatelessWidget {
  @override build(context) => Scaffold(
    appBar: AppBar(title: Text('Recorder')),
    body: VideoServerWidget(),
  );
}

class VideoServerWidget extends StatefulWidget {
  final int srvPort;
  VideoServerWidget([this.srvPort = SRV_PORT]);
  @override createState() => _State();
}

class _State extends State<VideoServerWidget> {
  HttpServer _server;
  WebSocket _socket;
  List<VideoPlayerController> _players = [null];
  VideoPlayerController _player;
  String _dir;
  Exception _err;
  bool _playing = false;
  int _received = 0;
  int _played = 0;

  @override initState() {
    super.initState();
    () async {
      try {
        _dir = (await getTemporaryDirectory()).path;
        _server = await HttpServer.bind(InternetAddress.anyIPv4, widget.srvPort);
        _server.listen((req) async {
          try {
            print('-------\n ${req.connectionInfo.remoteAddress} \n $_dir \n-------\n');
            _socket = await WebSocketTransformer.upgrade(req);
            _socket.listen((msg) async {
              try {
                final file = await File('$_dir/__${_received+1}.mp4').writeAsBytes(msg);
                final player = VideoPlayerController.file(file);
                await player.initialize();
                _players.add(player);
                _received++;
                if (!_playing && _played < _received) _play();
              } catch(e) { setState(() => _err = e); }
            });
          } catch(e) { setState(() => _err = e); }
        });
      } catch(e) { setState(() => _err = e); }
    }();
  }

  _play() async {
    try {
      _playing = true;
      _played++;
      _player = _players[_played];
      await _player.play();
      setState((){});
      _player.addListener(_onStop);
    } catch(e) { setState(() => _err = e); }
  }

  _onStop() async {
    if (!_player.value.isPlaying) {
      _player.removeListener(_onStop);
      if (_played < _received) {
        _play();
      } else {
        _playing = false;
      }
      setState((){});
      if (_played >= 3) {
        await _players[_played-2].dispose();
        _players[_played-2] = null;
        await File('$_dir/__${_played-2}.mp4').delete();
      }
    }
  }

  @override dispose() {
    _players.forEach((el) => el?.dispose());
    try { _socket.close(); } catch(_){}
    _server.close(force: true);
    super.dispose();
  }

  @override build(context) {
    if (_err != null) return Center(child: Text(_err.toString()));
    if (_played == 0) return Center(child: Text('Lisening port ${widget.srvPort}...'));
    return Column(children: [
      Text('$_played.mp4'),
      Expanded(child: AspectRatio(
        aspectRatio: _player.value.aspectRatio,
        child: VideoPlayer(_player),
      ))
    ]);
  }
}
