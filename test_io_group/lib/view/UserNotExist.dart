import 'package:flutter/material.dart';

import '../settings.dart';
import 'UserEdit.dart';

class UserNotExist extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Профиль еще не создан', style: h1),
            Container(height: 10),
            ElevatedButton(
              child: Text('Создать профиль'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UserEdit()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
