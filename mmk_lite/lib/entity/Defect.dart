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

  Map toMap() => {
        'certificate': certificate.toMap(),
        'position': position.toMap(),
        'productType': productType,
        'defectType': defectType.toMap(),
        'weightDefect': weightDefect,
        'arrangement': arrangement.toMap(),
        'remark': remark,
        //'defects': defects.map((d) => d.toMap()).toList();
      };

  Defect fromMap(Map m) {
    certificate = Certificate().fromMap(m['certificate']);
    position = m['position'];
    productType = m['productType'];
    defectType = m['defectType'];
    weightDefect = m['weightDefect'];
    arrangement = m['arrangement'];
    remark = remark;
    //defects = m['defects'].map((d) => Defect().fromMap(d)).toList();
    return this;
  }
}
