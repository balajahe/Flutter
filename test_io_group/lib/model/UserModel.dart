import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../dao/User.dart';

enum UserStatus { loading, notExist, exist, editing, notSaved, saved }

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
    // await Hive.initFlutter();
    // await Hive.openBox<User>('users');
    // _user = Hive.box<User>('users').get('me');
    if (_user == null) {
      _user = User();
      emit(UserState(_user, UserStatus.notExist));
    } else {
      emit(UserState(_user, UserStatus.exist));
    }
  }

  List<dynamic> _validate(User user) {
    if ((user.name?.isEmpty ?? true) ||
        (user.patronymic?.isEmpty ?? true) ||
        (user.surname.isEmpty ?? true) ||
        (user.email.isEmpty ?? true)) return [false, 'Заполните все поля!'];

    if (user.photoOrigin?.isEmpty ?? true)
      return [false, 'Загрузите фотографию!'];

    return [true];
  }

  void editName(String v) => _user.name = v;
  void editPatronymic(String v) => _user.patronymic = v;
  void editSurname(String v) => _user.surname = v;
  void editEmail(String v) => _user.email = v;
  void editPhotoOrigin(Uint8List v) {
    _user.photoOrigin = v;
    emit(UserState(_user, UserStatus.editing));
  }

  void save() {
    var valid = _validate(_user);
    if (valid[0]) {
      //Hive.box<User>('users').put('me', _user);
      emit(UserState(_user, UserStatus.saved));
    } else {
      emit(UserState(_user, UserStatus.notSaved, message: valid[1]));
    }
  }
}
