import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/SessionModel.dart';
import '../SessionLogin.dart';

class LogoutButton extends StatelessWidget {
  @override
  build(context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Logout',
      onPressed: () async {
        context.read<SessionModel>().logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SessionLogin()),
          (_) => false,
        );
      },
    );
  }
}
