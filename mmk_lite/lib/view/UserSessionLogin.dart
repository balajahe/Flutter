import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/UserSession.dart';
import '../model/UserSessionModel.dart';
import '../tools/common_widgets.dart';
import 'Home.dart';

class UserSessionLogin extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<UserSessionModel>();
    return BlocConsumer<UserSessionModel, UserSessionState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (state.data.authType == AuthType.registered)
                      ? [
                          Logo(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: TextEditingController(text: state.data.login),
                                decoration: InputDecoration(labelText: 'Логин'),
                                onChanged: (v) => model.set(login: v),
                              ),
                              TextField(
                                controller: TextEditingController(text: state.data.password),
                                decoration: InputDecoration(labelText: 'Пароль'),
                                onChanged: (v) => model.set(password: v),
                                obscureText: true,
                              ),
                              Container(height: 25),
                              Container(
                                width: 200,
                                child: ElevatedButton(
                                  child: Text('Авторизоваться'),
                                  onPressed: () => model.login(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnonAvatar(),
                              TextButton(
                                child: Text('Продолжить без авторизации'),
                                onPressed: () => model.toUnregistered(),
                              ),
                            ],
                          ),
                          Container(),
                        ]
                      : (state.data.authType == AuthType.unregistered)
                          ? [
                              Logo(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnonAvatar(),
                                  Text(
                                    'Для продолжения работы введите\ne-mail и номер телефона для связи',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  TextField(
                                    controller: TextEditingController(text: state.data.email),
                                    decoration: InputDecoration(labelText: 'e-mail'),
                                    onChanged: (v) => model.set(email: v),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextField(
                                    controller: TextEditingController(text: state.data.phone),
                                    decoration: InputDecoration(labelText: 'Номер телефона'),
                                    onChanged: (v) => model.set(phone: v),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  Container(height: 25),
                                  Container(
                                    width: 200,
                                    child: ElevatedButton(
                                      child: Text('Продолжить'),
                                      onPressed: () => model.login(),
                                    ),
                                  ),
                                ],
                              ),
                              Container(),
                            ]
                          : [],
                ),
              ),
              (state.waiting) ? Waiting() : Container(),
            ],
          ),
        );
      },
      listener: (cuntext, state) {
        if (state.userError != '')
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.userError)),
          );
        else if (state.done)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Home()),
            (_) => false,
          );
      },
    );
  }
}
