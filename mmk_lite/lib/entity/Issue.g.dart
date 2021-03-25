// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Issue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueAdapter extends TypeAdapter<Issue> {
  @override
  final int typeId = 50;

  @override
  Issue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Issue()
      ..id = fields[0] as String
      ..date = fields[1] as DateTime
      ..defects = (fields[2] as List)?.cast<Defect>();
  }

  @override
  void write(BinaryWriter writer, Issue obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.defects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
