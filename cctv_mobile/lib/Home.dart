import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';
import 'BothLocally.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _serverPort = TextEditingController(text: '8080');
  final _serverIp = TextEditingController(text: '192.168.30.80');
  double _cameraResolution = 2;
  double _dropFrames = 8;

  @override
  build(context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              height: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Recorder port:')),
                      Expanded(child: TextField(controller: _serverPort)),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Run Recorder'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Recorders(
                            int.parse(_serverPort.text),
                          ),
                        )),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(child: Text('Recorder IP:')),
                      Expanded(flex: 2, child: TextField(controller: _serverIp)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Cam resolution:')),
                      Expanded(
                        flex: 2,
                        child: Slider(
                          value: _cameraResolution,
                          min: 0,
                          max: 5,
                          divisions: 5,
                          label: _cameraResolution.round().toString(),
                          onChanged: (v) => setState(() => _cameraResolution = v),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Drop frames:')),
                      Expanded(
                        flex: 2,
                        child: Slider(
                          value: _dropFrames,
                          min: 0,
                          max: 20,
                          divisions: 10,
                          label: _dropFrames.round().toString(),
                          onChanged: (v) => setState(() => _dropFrames = v),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Run Camera'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Camera(
                            _serverIp.text,
                            int.parse(_serverPort.text),
                            _cameraResolution.toInt(),
                            _dropFrames.toInt(),
                          ),
                        )),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    child: Text('Run both locally'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BothLocally(),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
