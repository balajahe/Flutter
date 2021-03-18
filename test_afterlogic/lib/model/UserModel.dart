import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/User.dart';
import '../dao/DaoSession.dart';

class UserState extends AbstractState<User> {
  UserState(User data) : super(data);
}

class UserModel extends Cubit<UserState> {
  User _data = User();
  DaoSession _daoSession;

  UserModel() : super(UserState(User()));

  DaoSession get daoSession => _daoSession;

  void set({String host, String email, String password}) {
    _data.host = host ?? _data.host;
    _data.email = email ?? _data.email;
    _data.password = password ?? _data.password;
  }

  void login() async {
    if (_data.host.length * _data.email.length * _data.password.length == 0) {
      emit(UserState(_data)..error = 'Fill in all fields!');
    } else if (!_validateEmail(_data.email)) {
      emit(UserState(_data)..error = 'Email is incorrect!');
    } else {
      try {
        emit(UserState(_data)..waiting = true);
        _daoSession = DaoSession();
        await _daoSession.login(_data);
        _data.password = '';
        emit(UserState(_data)..done = true);
      } catch (e) {
        print(e.toString());
        emit(UserState(_data)..error = 'Authentification error!');
      }
    }
  }

  bool _validateEmail(String v) {
    return RegExp(
            r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
        .hasMatch(v);
  }
}
