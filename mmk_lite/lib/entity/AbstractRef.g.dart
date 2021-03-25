// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AbstractRef.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbstractRefAdapter extends TypeAdapter<AbstractRef> {
  @override
  final int typeId = 0;

  @override
  AbstractRef read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbstractRef()
      ..id = fields[0] as String
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, AbstractRef obj) {
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
      other is AbstractRefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
