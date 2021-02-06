import 'package:flutter/material.dart';
import './VideoServer.dart';
import './VideoClient.dart';
import './VideoTest.dart';

const TITLE = 'CCTV Mobile';

void main() => runApp(MaterialApp(
  title: TITLE,
  theme: ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  home: Home(),
));
  
class Home extends StatelessWidget {
  @override build(context) => Scaffold(
    appBar: AppBar(title: Text(TITLE)),
    body: Center(child: Container(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RaisedButton(
            child: Text('Start server (recorder)'),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoServerPage()))
          ),
          RaisedButton(
            child: Text('Start client (camera)'),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoClientPage()))
          ),
          RaisedButton(
            child: Text('Test both locally'),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoTestPage()))
          ),
        ],
      )
    ))
  );
}
