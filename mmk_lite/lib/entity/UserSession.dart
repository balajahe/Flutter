import 'dart:typed_data';
import 'package:hive/hive.dart';

@HiveType(typeId: 71)
enum AuthType {
  @HiveField(0)
  registered,

  @HiveField(1)
  unregistered
}

@HiveType(typeId: 70)
class UserSession {
  @HiveField(0)
  AuthType authType = AuthType.registered;

  @HiveField(1)
  String login = '';

  @HiveField(2)
  String password = '';

  @HiveField(3)
  String email = '';

  @HiveField(4)
  String phone = '';

  @HiveField(5)
  String name = '';

  @HiveField(6)
  Uint8List avatar = Uint8List(0);
}
