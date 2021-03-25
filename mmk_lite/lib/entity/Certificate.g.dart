// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Certificate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CertificateAdapter extends TypeAdapter<Certificate> {
  @override
  final int typeId = 20;

  @override
  Certificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificate()
      ..order = fields[10] as String
      ..date = fields[11] as DateTime
      ..id = fields[0] as String
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Certificate obj) {
    writer
      ..writeByte(4)
      ..writeByte(10)
      ..write(obj.order)
      ..writeByte(11)
      ..write(obj.date)
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
      other is CertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
