import 'package:flutter/material.dart';

import '../UserLogin.dart';

class LogoutButton extends StatelessWidget {
  @override
  build(context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Logout',
      onPressed: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SessionLogin()),
          (_) => false,
        );
      },
    );
  }
}
