import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/UserSession.dart';
import '../dao/UserSessionDao.dart';
import 'AbstractState.dart';

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
        await _dao.login(_data);
        emit(UserSessionState(_data)..done = true);
      }
    } else if (_data.authType == AuthType.unregistered) {
      var userError = '';
      if (!_validateEmail(_data.email)) userError += 'Введите правильный e-mail!\n';
      if (!_validatePhone(_data.phone)) userError += 'Введите правильный номер телефона!\n';
      if (userError.length > 0) {
        emit(UserSessionState(_data)..userError = userError.trimRight());
      } else {
        emit(UserSessionState(_data)..waiting = true);
        await _dao.login(_data);
        emit(UserSessionState(_data)..done = true);
      }
    }
  }

  bool _validatePhone(String v) {
    return RegExp(r'(^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$)').hasMatch(v);
  }

  bool _validateEmail(String v) {
    return RegExp(
            r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
        .hasMatch(v);
  }
}
