import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/UserSession.dart';
import '../dao/UserSessionDao.dart';
import 'AbstractState.dart';
import '../tools/mmk_tools.dart';

class UserSessionState extends AbstractState {
  UserSession data;
  UserSessionState(this.data);
}

class UserSessionModel extends Cubit<UserSessionState> {
  UserSession _data = UserSession();
  UserSessionDao _dao = UserSessionDao();

  UserSessionModel() : super(UserSessionState(UserSession()));

  void set({String login, String password, String email, String phone}) {
    _data.login = login ?? _data.login;
    _data.password = password ?? _data.password;
    _data.email = email ?? _data.email;
    _data.phone = phone ?? _data.phone;
  }

  void toUnregistered() {
    _data.authType = AuthType.unregistered;
    emit(UserSessionState(_data));
  }

  void login() async {
    if (_data.authType == AuthType.registered) {
      if (_data.login.length * _data.password.length == 0) {
        emit(UserSessionState(_data)..userError = 'Введите логин и пароль!');
      } else {
        emit(UserSessionState(_data)..waiting = true);
        await Future.delayed(Duration(seconds: 1));
        emit(UserSessionState(_data)..done = true);
      }
    } else if (_data.authType == AuthType.unregistered) {
      var userError = '';
      if (!validateEmail(_data.email)) userError += 'Введите правильный e-mail!\n';
      if (!validatePhone(_data.phone)) userError += 'Введите правильный номер телефона!\n';
      if (userError.length > 0) {
        emit(UserSessionState(_data)..userError = userError.trimRight());
      } else {
        emit(UserSessionState(_data)..waiting = true);
        await Future.delayed(Duration(seconds: 1));
        emit(UserSessionState(_data)..done = true);
      }
    }
  }
}
