import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/AppUser.dart';
import '../model/AppUserSession.dart';
import 'IssueAdd.dart';
import 'common.dart';

class AppUserLogin extends StatelessWidget {
  @override
  build(context) {
    return BlocConsumer<AppUserSession, AppUser>(
      builder: (context, state) {
        var model = context.read<AppUserSession>();
        print(state.authStatus);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
            child: (state.authType == AuthType.registered)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MmkLogo(),
                      Column(
                        children: [
                          TextField(
                            controller:
                                TextEditingController(text: state.login),
                            decoration: InputDecoration(labelText: 'Логин'),
                            onChanged: (v) => model.set(login: v),
                          ),
                          TextField(
                            controller: TextEditingController(),
                            decoration: InputDecoration(labelText: 'Пароль'),
                            onChanged: (v) => model.set(password: v),
                            obscureText: true,
                          ),
                          Container(height: 30),
                          MmkElevatedButton(
                            child: Text('Авторизоваться'),
                            onPressed: () => model.login(),
                          ),
                        ],
                      ),
                      TextButton(
                        child: Text('Продолжить без авторизации'),
                        onPressed: () => model.toUnregistered(),
                      ),
                    ],
                  )
                : (state.authType == AuthType.unregistered)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MmkLogo(),
                          Column(
                            children: [
                              TextField(
                                controller:
                                    TextEditingController(text: state.email),
                                decoration:
                                    InputDecoration(labelText: 'e-mail'),
                                onChanged: (v) => model.set(email: v),
                              ),
                              TextField(
                                controller:
                                    TextEditingController(text: state.phone),
                                decoration: InputDecoration(
                                    labelText: 'Номер телефона'),
                                onChanged: (v) => model.set(phone: v),
                              ),
                              Container(height: 30),
                              MmkElevatedButton(
                                child: Text('Продолжить'),
                                onPressed: () => model.login(),
                              ),
                            ],
                          ),
                          Container(),
                        ],
                      )
                    : Center(child: Text('fuck')),
          ),
        );
      },
      listener: (cuntext, state) {
        if (state.authStatus == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.authStatusError)),
          );
        } else if (state.authStatus == AuthStatus.ok) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => IssueAdd()),
            (_) => false,
          );
        }
      },
    );
  }
}
