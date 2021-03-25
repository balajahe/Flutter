// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Defect.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefectAdapter extends TypeAdapter<Defect> {
  @override
  final int typeId = 30;

  @override
  Defect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Defect()
      ..certificate = fields[0] as Certificate
      ..position = fields[1] as Position
      ..productType = fields[2] as String
      ..defectType = fields[3] as DefectType
      ..weightDefect = fields[4] as double
      ..arrangement = fields[5] as Arrangement
      ..remark = fields[6] as String
      ..files = (fields[7] as List)?.cast<Uint8List>();
  }

  @override
  void write(BinaryWriter writer, Defect obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.certificate)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.productType)
      ..writeByte(3)
      ..write(obj.defectType)
      ..writeByte(4)
      ..write(obj.weightDefect)
      ..writeByte(5)
      ..write(obj.arrangement)
      ..writeByte(6)
      ..write(obj.remark)
      ..writeByte(7)
      ..write(obj.files);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
