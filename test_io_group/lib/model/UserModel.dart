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
  UserModel() : super(UserState(null, UserStatus.loading)) {
    _load();
  }

  void _load() async {
    await Hive.initFlutter();
    await Hive.openBox<User>('users');

    var user = Hive.box<User>('users').get('me');
    if (user == null) {
      emit(UserState(User(), UserStatus.notExist));
    } else {
      emit(UserState(user, UserStatus.exist));
    }
  }

  List<dynamic> _validate(User user) {
    if (user.name.isEmpty ||
        user.patronymic.isEmpty ||
        user.surname.isEmpty ||
        user.email.isEmpty) return [false, 'Заполните все поля!'];

    if (user.photoOrigin == null || user.photoOrigin.isEmpty)
      return [false, 'Загрузите фотографию!'];

    return [true];
  }

  void save(User user) {
    var valid = _validate(user);
    if (valid[0]) {
      //Hive.box<User>('users').put('me', _user);
      emit(UserState(user, UserStatus.saved));
    } else {
      emit(UserState(user, UserStatus.notSaved, message: valid[1]));
    }
  }
}
