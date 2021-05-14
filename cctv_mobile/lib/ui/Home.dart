import 'package:flutter/material.dart';
import 'Client.dart';

class Home extends StatelessWidget {
  @override
  build(context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(child: Text('Server (recorder)'), onPressed: null),
            ElevatedButton(
              child: Text('Client (camera)'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Client())),
            ),
          ],
        ),
      ),
    );
  }
}
