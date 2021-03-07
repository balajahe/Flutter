import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/User.dart';
import '../model/UserModel.dart';
import 'mmk_widgets.dart';
import 'Home.dart';

class UserLogin extends StatelessWidget {
  @override
  build(context) {
    return BlocConsumer<UserModel, User>(
      builder: (context, state) {
        var model = context.read<UserModel>();
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 30),
                child: (state.authType == AuthType.registered)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Logo(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller:
                                    TextEditingController(text: state.login),
                                decoration: InputDecoration(labelText: 'Логин'),
                                onChanged: (v) => model.set(login: v),
                              ),
                              TextField(
                                controller:
                                    TextEditingController(text: state.password),
                                decoration:
                                    InputDecoration(labelText: 'Пароль'),
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
                        ],
                      )
                    : (state.authType == AuthType.unregistered)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Logo(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnonAvatar(),
                                  Container(height: 10),
                                  Text(
                                    'Для продолжения работы\nвведите e-mail и номер телефона\nдля связи',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: TextEditingController(
                                        text: state.email),
                                    decoration:
                                        InputDecoration(labelText: 'e-mail'),
                                    onChanged: (v) => model.set(email: v),
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: state.phone),
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
                        : Container(),
              ),
              (state.authStatus == AuthStatus.wait)
                  ? Container(
                      color: Color.fromARGB(200, 60, 60, 60),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(),
            ],
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
            MaterialPageRoute(builder: (_) => Home()),
            (_) => false,
          );
        }
      },
    );
  }
}
