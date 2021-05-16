import 'package:flutter/material.dart';
import 'Server.dart';
import 'Client.dart';

class Home extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Start Server (recorder)'),
                      onPressed: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Server())),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Server IP-address'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Start Camera'),
                      onPressed: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Client())),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
