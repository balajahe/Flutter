import 'dart:typed_data';

enum AuthType { registered, unregistered }

enum AuthStatus { none, wait, ok, error }

class User {
  AuthType authType = AuthType.registered;
  AuthStatus authStatus = AuthStatus.none;
  String authStatusError;
  String login = '';
  String password = '';
  String email = '';
  String phone = '';
  String name;
  Uint8List avatar;

  User clone() => User()
    ..authType = authType
    ..authStatus = authStatus
    ..authStatusError = authStatusError
    ..login = login
    ..password = password
    ..email = email
    ..phone = phone
    ..name = name
    ..avatar = avatar;
}
