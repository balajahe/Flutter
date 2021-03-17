import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/UserController.dart';
import 'afterlogic_widgets.dart';
import 'ContactListPerson.dart';

class UserLogin extends StatelessWidget {
  @override
  build(context) {
    var controller = context.read<UserController>();
    return BlocConsumer<UserController, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Contact Manager', style: TextStyle(fontSize: 20)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: TextEditingController(text: state.data.host),
                          decoration: InputDecoration(labelText: 'Host'),
                          onChanged: (v) => controller.set(host: v),
                        ),
                        TextField(
                          controller: TextEditingController(text: state.data.email),
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (v) => controller.set(email: v),
                        ),
                        TextField(
                          controller: TextEditingController(text: state.data.password),
                          decoration: InputDecoration(labelText: 'Password'),
                          onChanged: (v) => controller.set(password: v),
                          obscureText: true,
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        child: Text('LOGIN'),
                        onPressed: () => controller.login(),
                      ),
                    ),
                  ],
                ),
              ),
              (state.waiting) ? Waiting() : Container(),
            ],
          ),
        );
      },
      listener: (cuntext, state) {
        if (state.error != '')
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: SelectableText(state.error)),
          );
        else if (state.done)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ContactListPerson()),
            (_) => false,
          );
      },
    );
  }
}
