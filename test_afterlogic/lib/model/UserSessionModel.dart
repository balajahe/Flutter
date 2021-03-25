import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/UserSession.dart';
import '../dao/UserSessionDao.dart';

class UserSessionState extends AbstractState {
  UserSession data;
  UserSessionState(this.data);
}

class UserSessionModel extends Cubit<UserSessionState> {
  UserSession _data = UserSession();
  UserSessionDao _dao;

  UserSessionModel() : super(UserSessionState(UserSession()));

  UserSessionDao get dao => _dao;

  void set({String host, String email, String password}) {
    _data.host = host ?? _data.host;
    _data.email = email ?? _data.email;
    _data.password = password ?? _data.password;
  }

  Future<void> login() async {
    if (_data.host.length * _data.email.length * _data.password.length == 0) {
      emit(UserSessionState(_data)..error = 'Fill in all fields!');
    } else if (!_validateEmail(_data.email)) {
      emit(UserSessionState(_data)..error = 'Email is incorrect!');
    } else {
      try {
        emit(UserSessionState(_data)..waiting = true);
        _dao = UserSessionDao();
        await _dao.login(_data);
        _data.password = '';
        emit(UserSessionState(_data)..done = true);
      } catch (e) {
        print(e.toString());
        emit(UserSessionState(_data)..error = 'Authentification error!');
      }
    }
  }

  Future<void> logout() async {
    _data = UserSession();
    emit(UserSessionState(_data));
  }

  bool _validateEmail(String v) {
    return RegExp(
            r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
        .hasMatch(v);
  }
}
