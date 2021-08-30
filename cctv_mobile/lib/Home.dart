import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';
import 'BothLocally.dart';

final _serverPort = TextEditingController(text: '8080');
final _serverIp = TextEditingController(text: '192.168.30.80');
final _dropFrames = TextEditingController(text: '5');

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
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Recorder port:'),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(controller: _serverPort),
                  ),
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
                  Expanded(
                    flex: 1,
                    child: Text('Recorder address:'),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(controller: _serverIp),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Drop frames:'),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(controller: _dropFrames),
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
