import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/UserModel.dart';
import '../UserLogin.dart';

class LogoutButton extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<UserModel>();
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
