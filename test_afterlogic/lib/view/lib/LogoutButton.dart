import 'package:flutter/material.dart';
import '../SessionLogin.dart';

class LogoutButton extends StatelessWidget {
  @override
  build(context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Logout',
      onPressed: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SessionLogin()),
        (_) => false,
      ),
    );
  }
}
