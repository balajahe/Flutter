import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorder.dart';
import 'BothLocally.dart';

final _serverIp = TextEditingController(text: '192.168.XX.80');
final _serverPort = TextEditingController(text: '8080');

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
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Recorder IP:'),
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
                    child: Text('Recorder Port:'),
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
                        builder: (_) => Recorder(
                              int.parse(_serverPort.text),
                            ))),
              ),
              Container(height: 10),
              ElevatedButton(
                child: Text('Run Camera'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Camera(
                              _serverIp.text,
                              int.parse(_serverPort.text),
                            ))),
              ),
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
