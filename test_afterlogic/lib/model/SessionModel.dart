import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'AbstractState.dart';
import '../entity/Session.dart';
import '../dao/SessionDao.dart';

class SessionState extends AbstractState<Session> {
  SessionState(Session data) : super(data);
}

class SessionModel extends Cubit<SessionState> {
  Session _data = Session();
  SessionDao _dao;

  SessionModel() : super(SessionState(Session()));

  SessionDao get dao => _dao;

  void set({String host, String email, String password}) {
    _data.host = host ?? _data.host;
    _data.email = email ?? _data.email;
    _data.password = password ?? _data.password;
  }

  void login() async {
    if (_data.host.length * _data.email.length * _data.password.length == 0) {
      emit(SessionState(_data)..error = 'Fill in all the fields!');
    } else if (!_validateEmail(_data.email)) {
      emit(SessionState(_data)..error = 'Email is incorrect!');
    } else {
      try {
        emit(SessionState(_data)..waiting = true);
        _dao = SessionDao();
        _data = await _dao.login(_data);
        _data.password = '';
        emit(SessionState(_data)..done = true);
      } catch (e) {
        emit(SessionState(_data)..error = e.toString());
      }
    }
  }

  bool _validateEmail(String v) {
    return RegExp(
            r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
        .hasMatch(v);
  }
}
