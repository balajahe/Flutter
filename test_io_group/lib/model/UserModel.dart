import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../dao/User.dart';

enum UserStatus { loading, notExist, exist, notSaved, saved }

class UserState {
  final User user;
  final UserStatus status;
  final String message;
  UserState(this.user, this.status, {this.message});
}

class UserModel extends Cubit<UserState> {
  User _user;

  UserModel() : super(UserState(null, UserStatus.loading)) {
    _load();
  }

  void _load() async {
    await Hive.initFlutter();
    await Hive.openBox<User>('users');

    _user = Hive.box<User>('users').get('me');
    if (_user == null) {
      _user = User();
      emit(UserState(_user, UserStatus.notExist));
    } else {
      emit(UserState(_user, UserStatus.exist));
    }
  }

  List _validate(User user) => [true, ''];

  void save(User user) {
    var valid = _validate(user);
    if (valid[0]) {
      _user = user;
      //Hive.box<User>('users').put('me', _user);
      emit(UserState(_user, UserStatus.saved));
    } else {
      emit(UserState(_user, UserStatus.notSaved, message: valid[1]));
    }
  }

  void _emitChange() => emit(UserState(_user, UserStatus.exist));

  void setName(String name) {
    _user.name = name;
    _emitChange();
  }
}
