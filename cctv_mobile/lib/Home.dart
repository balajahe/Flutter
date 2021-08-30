import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';
import 'BothLocally.dart';

final _serverPort = TextEditingController(text: '8080');
final _serverIp = TextEditingController(text: '192.168.30.80');
final _cameraResolution = TextEditingController(text: '2');
final _dropFrames = TextEditingController(text: '7');

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  build(context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 350,
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
                            ))),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(child: Text('Recorder address:')),
                  Expanded(child: TextField(controller: _serverIp)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text('Camera resolution:')),
                  Expanded(child: TextField(controller: _cameraResolution)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text('Drop frames:')),
                  Expanded(child: TextField(controller: _dropFrames)),
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
                              int.parse(_cameraResolution.text),
                              int.parse(_dropFrames.text),
                            ))),
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('Run both locally'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BothLocally())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
