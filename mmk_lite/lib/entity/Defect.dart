import 'dart:typed_data';

import 'Certificate.dart';
import 'Position.dart';
import 'DefectType.dart';
import 'Arrangement.dart';

class Defect {
  Certificate certificate = Certificate();
  Position position = Position();
  String productType = '';
  DefectType defectType = DefectType();
  double weightDefect = 0;
  Arrangement arrangement = Arrangement();
  String remark = '';
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
