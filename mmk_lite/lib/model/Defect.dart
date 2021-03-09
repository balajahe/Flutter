import 'dart:typed_data';

class Defect {
  String certificate = '';
  String position = '';
  String productType = '';
  String defectType = '';
  String notificationNum = '';
  double marriageWeight;
  String settlement = '';
  String notes = '';
  List<Uint8List> photos = [];

  Defect clone() => Defect()
    ..certificate = certificate
    ..position = position
    ..productType = productType
    ..defectType = defectType
    ..notificationNum = notificationNum
    ..marriageWeight = marriageWeight
    ..settlement = settlement
    ..notes = notes
    ..photos = List.from(photos);
}
