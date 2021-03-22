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
  String notificationNum = '';
  double marriageWeight = 0;
  Arrangement arrangement = Arrangement();
  String notes = '';
  List<Uint8List> images = [];
}
