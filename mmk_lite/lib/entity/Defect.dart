import 'dart:typed_data';

import 'Certificate.dart';
import 'Position.dart';
import 'DefectType.dart';
import 'Arrangement.dart';

class DefectFile {
  String name;
  Uint8List file;
  DefectFile(this.name, this.file);
}

class Defect {
  Certificate certificate = Certificate();
  Position position = Position();
  String productType = '';
  DefectType defectType = DefectType();
  double weightDefect = 0;
  Arrangement arrangement = Arrangement();
  String remark = '';
  List<DefectFile> files = [];

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
        'files': files.map((d) => d.name).toList(),
      };

  Defect fromMap(Map m) {
    certificate = Certificate().fromMap(m['certificate']);
    position = Position().fromMap(m['position']);
    productType = m['productType'];
    defectType = DefectType().fromMap(m['defectType']);
    weightDefect = m['weightDefect'];
    arrangement = Arrangement().fromMap(m['arrangement']);
    remark = m['remark'];
    files = m['files'].map<DefectFile>((f) => DefectFile(f.name, Uint8List(0))).toList();
    return this;
  }
}
