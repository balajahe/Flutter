import 'package:flutter/material.dart';
import 'Camera.dart';
import 'Recorders.dart';
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
