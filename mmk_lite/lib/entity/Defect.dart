import 'dart:typed_data';
import 'package:hive/hive.dart';

import 'Certificate.dart';
import 'Position.dart';
import 'DefectType.dart';
import 'Arrangement.dart';

@HiveType(typeId: 30)
class Defect {
  @HiveField(0)
  Certificate certificate = Certificate();

  @HiveField(1)
  Position position = Position();

  @HiveField(2)
  String productType = '';

  @HiveField(3)
  DefectType defectType = DefectType();

  @HiveField(4)
  double weightDefect = 0;

  @HiveField(5)
  Arrangement arrangement = Arrangement();

  @HiveField(6)
  String remark = '';

  @HiveField(7)
  List<Uint8List> files = [];

  Defect clone() => Defect()
    ..certificate = certificate
    ..position = position
    ..productType = productType
    ..defectType = defectType
    ..weightDefect = weightDefect
    ..arrangement = arrangement
    ..remark = remark
    ..files = List.from(files);
}
