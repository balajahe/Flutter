import 'dart:convert';
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
        'files': files
            .map((f) => {
                  'name': f.name,
                  'file': f.file,
                })
            .toList(),
      };

  Defect fromMap(Map m) {
    certificate = Certificate().fromMap(m['certificate']);
    position = Position().fromMap(m['position']);
    productType = m['productType'];
    defectType = DefectType().fromMap(m['defectType']);
    weightDefect = m['weightDefect'];
    arrangement = Arrangement().fromMap(m['arrangement']);
    remark = m['remark'];
    files = m['files']
        .map<DefectFile>((f) => DefectFile(
              f['name'],
              f['file'],
            ))
        .toList();
    return this;
  }

  bool equal(Defect d) {
    var d1 = toMap();
    d1['files'] = files.map((f) => f.name).toList();
    var d2 = d.toMap();
    d2['files'] = files.map((f) => f.name).toList();
    return (jsonEncode(d1) == jsonEncode(d2));
  }
}
