import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0, adapterName: 'UserAdapter')
class User {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String patronymic;

  @HiveField(3)
  String surname;

  @HiveField(4)
  String email;

  @HiveField(5)
  Uint8List photoOrigin;

  @HiveField(6)
  Uint8List photoSmall;

  User({
    this.id,
    this.name,
    this.patronymic,
    this.surname,
    this.email,
    this.photoOrigin,
    this.photoSmall,
  }) {
    if (id == null || id == 0) id = DateTime.now().millisecondsSinceEpoch;
  }
}
