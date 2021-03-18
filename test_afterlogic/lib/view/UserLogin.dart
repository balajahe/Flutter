import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/SessionModel.dart';
import 'lib/common_widgets.dart';
import 'ContactList.dart';

class SessionLogin extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<SessionModel>();
    return BlocConsumer<SessionModel, SessionState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Contact Manager',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: TextEditingController(text: state.data.host),
                          decoration: InputDecoration(labelText: 'Host'),
                          onChanged: (v) => model.set(host: v),
                        ),
                        Container(height: 20),
                        TextField(
                          controller: TextEditingController(text: state.data.email),
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (v) => model.set(email: v),
                        ),
                        Container(height: 20),
                        TextField(
                          controller: TextEditingController(text: state.data.password),
                          decoration: InputDecoration(labelText: 'Password'),
                          onChanged: (v) => model.set(password: v),
                          obscureText: true,
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      height: 35,
                      child: ElevatedButton(
                        child: Text('LOGIN'),
                        onPressed: () => model.login(),
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
            SnackBar(content: Text(state.error)),
          );
        else if (state.done)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ContactList()),
            (_) => false,
          );
      },
    );
  }
}
