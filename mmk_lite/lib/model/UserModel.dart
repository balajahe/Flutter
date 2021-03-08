import 'package:flutter_bloc/flutter_bloc.dart';

import 'User.dart';

class UserModel extends Cubit<User> {
  User _current;

  UserModel() : super(User()) {
    _current = User();
  }

  void set({String login, String password, String email, String phone}) {
    _current.login = login ?? _current.login;
    _current.password = password ?? _current.password;
    _current.email = email ?? _current.email;
    _current.phone = phone ?? _current.phone;
  }

  void toUnregistered() {
    _current.authType = AuthType.unregistered;
    _current.authStatus = AuthStatus.none;
    _emit();
  }

  void login() async {
    if (_current.authType == AuthType.registered) {
      if (_current.login.length * _current.password.length == 0) {
        _current.authStatus = AuthStatus.error;
        _current.authStatusError = 'Введите логин и пароль';
      } else {
        _wait();
        await Future.delayed(Duration(seconds: 2));
        _current.authStatus = AuthStatus.ok;
      }
    } else if (_current.authType == AuthType.unregistered) {
      if (_current.email.length * _current.phone.length == 0) {
        _current.authStatus = AuthStatus.error;
        _current.authStatusError = 'Введите e-mail и номер телефона';
      } else {
        _wait();
        await Future.delayed(Duration(seconds: 2));
        _current.authStatus = AuthStatus.ok;
      }
    }
    _emit();
  }

  void _emit() => emit(_current.clone());

  void _wait() {
    _current.authStatus = AuthStatus.wait;
    _emit();
  }
}
