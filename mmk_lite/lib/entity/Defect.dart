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
  double marriageWeight = 0;
  Arrangement arrangement = Arrangement();
  String notes = '';
  List<Uint8List> images = [];

  Defect clone() => Defect()
    ..certificate = certificate
    ..position = position
    ..productType = productType
    ..defectType = defectType
    ..marriageWeight = marriageWeight
    ..arrangement = arrangement
    ..notes = notes
    ..images = List.from(images);
}
