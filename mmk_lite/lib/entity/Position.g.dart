// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Position.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionAdapter extends TypeAdapter<Position> {
  @override
  final int typeId = 60;

  @override
  Position read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Position()
      ..num = fields[10] as int
      ..roll = fields[11] as String
      ..batch = fields[12] as String
      ..dimensions = fields[13] as String
      ..quantity = fields[14] as double
      ..id = fields[0] as String
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Position obj) {
    writer
      ..writeByte(7)
      ..writeByte(10)
      ..write(obj.num)
      ..writeByte(11)
      ..write(obj.roll)
      ..writeByte(12)
      ..write(obj.batch)
      ..writeByte(13)
      ..write(obj.dimensions)
      ..writeByte(14)
      ..write(obj.quantity)
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
      other is PositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
