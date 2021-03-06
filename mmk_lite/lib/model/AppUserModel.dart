import 'package:flutter_bloc/flutter_bloc.dart';

import 'AppUser.dart';

class AppUserModel extends Cubit<AppUser> {
  AppUser _user;

  AppUserModel() : super(AppUser()) {
    _user = AppUser();
  }

  void set({String login, String password, String email, String phone}) {
    _user.login = login;
    _user.password = login;
    _user.email = email;
    _user.phone = phone;
  }

  void toUnregistered() {
    _user.authType = AuthType.unregistered;
    emit(_user);
  }

  void login() async {
    if (_user.authType == AuthType.registered) {
      if (_user.login.length * _user.password.length > 0) {
        _user.authStatus = AuthStatus.ok;
      } else {
        _user.authStatus = AuthStatus.error;
        _user.authStatusError = 'Введите логин и пароль!';
      }
    } else {
      _user.authStatus = AuthStatus.ok;
    }
    emit(_user);
  }
}
