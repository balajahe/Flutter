import 'dart:typed_data';

enum AuthType { registered, unregistered }

class UserSession {
  AuthType authType = AuthType.registered;
  String login = '';
  String password = '';
  String email = '';
  String phone = '';
  String name;
  Uint8List avatar;
}
