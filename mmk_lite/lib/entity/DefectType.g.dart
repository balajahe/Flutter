// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DefectType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefectTypeAdapter extends TypeAdapter<DefectType> {
  @override
  final int typeId = 40;

  @override
  DefectType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DefectType()
      ..id = fields[0] as String
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, DefectType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefectTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
