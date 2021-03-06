import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/User.dart';
import '../model/UserModel.dart';
import 'lib/common.dart';
import 'IssueAdd.dart';

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
                    EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
                child: (state.authType == AuthType.registered)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MmkLogo(),
                          Column(
                            children: [
                              MmkTextField(
                                text: state.login,
                                label: 'Логин',
                                onChanged: (v) => model.set(login: v),
                              ),
                              MmkTextField(
                                text: state.password,
                                label: 'Пароль',
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
                                  MmkTextField(
                                    text: state.email,
                                    label: 'e-mail',
                                    onChanged: (v) => model.set(email: v),
                                  ),
                                  MmkTextField(
                                    text: state.phone,
                                    label: 'Номер телефона',
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
            MaterialPageRoute(builder: (_) => IssueAdd()),
            (_) => false,
          );
        }
      },
    );
  }
}
