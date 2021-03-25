// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSession.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthTypeAdapter extends TypeAdapter<AuthType> {
  @override
  final int typeId = 71;

  @override
  AuthType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AuthType.registered;
      case 1:
        return AuthType.unregistered;
      default:
        return AuthType.registered;
    }
  }

  @override
  void write(BinaryWriter writer, AuthType obj) {
    switch (obj) {
      case AuthType.registered:
        writer.writeByte(0);
        break;
      case AuthType.unregistered:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserSessionAdapter extends TypeAdapter<UserSession> {
  @override
  final int typeId = 70;

  @override
  UserSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSession()
      ..authType = fields[0] as AuthType
      ..login = fields[1] as String
      ..password = fields[2] as String
      ..email = fields[3] as String
      ..phone = fields[4] as String
      ..name = fields[5] as String
      ..avatar = fields[6] as Uint8List;
  }

  @override
  void write(BinaryWriter writer, UserSession obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.authType)
      ..writeByte(1)
      ..write(obj.login)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
