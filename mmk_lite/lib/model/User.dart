import 'dart:typed_data';

enum AuthType { registered, unregistered }

enum AuthStatus { none, wait, ok, error }

class User {
  AuthType authType;
  AuthStatus authStatus;
  String authStatusError;
  String login;
  String password;
  String email;
  String phone;
  String name;
  Uint8List avatar;

  User({
    this.authType = AuthType.registered,
    this.authStatus = AuthStatus.none,
    this.authStatusError,
    this.login = '',
    this.password = '',
    this.email = '',
    this.phone = '',
    this.name,
    this.avatar,
  });

  User clone() => User(
        authType: authType,
        authStatus: authStatus,
        authStatusError: authStatusError,
        login: login,
        password: password,
        email: email,
        phone: phone,
        name: name,
        avatar: avatar,
      );
}
