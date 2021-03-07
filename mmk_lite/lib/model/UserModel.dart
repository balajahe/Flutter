import 'package:flutter_bloc/flutter_bloc.dart';

import 'User.dart';

class UserModel extends Cubit<User> {
  User _user;

  UserModel() : super(User()) {
    _user = User();
  }

  void set({String login, String password, String email, String phone}) {
    _user.login = login ?? _user.login;
    _user.password = password ?? _user.password;
    _user.email = email ?? _user.email;
    _user.phone = phone ?? _user.phone;
  }

  void toUnregistered() {
    _user.authType = AuthType.unregistered;
    _user.authStatus = AuthStatus.none;
    _emit();
  }

  void login() async {
    if (_user.authType == AuthType.registered) {
      if (_user.login.length * _user.password.length == 0) {
        _user.authStatus = AuthStatus.error;
        _user.authStatusError = 'Введите логин и пароль';
      } else {
        _wait();
        await Future.delayed(Duration(seconds: 2));
        _user.authStatus = AuthStatus.ok;
      }
    } else if (_user.authType == AuthType.unregistered) {
      if (_user.email.length * _user.phone.length == 0) {
        _user.authStatus = AuthStatus.error;
        _user.authStatusError = 'Введите e-mail и номер телефона';
      } else {
        _wait();
        await Future.delayed(Duration(seconds: 2));
        _user.authStatus = AuthStatus.ok;
      }
    }
    _emit();
  }

  void _emit() => emit(_user.clone());

  void _wait() {
    _user.authStatus = AuthStatus.wait;
    _emit();
  }
}
