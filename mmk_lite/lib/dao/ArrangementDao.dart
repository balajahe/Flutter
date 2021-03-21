import '../entity/DefectType.dart';

const json = [
  {
    "ID": "213",
    "ARRANGEMENT": "Возможно использование без выставления претензии, требуется разработка корректирующих мероприятий",
    "LANG": "ru"
  },
];

class ArrangementDao {
  Future<List<DefectType>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return json
        .map((v) => DefectType()
          ..id = v['ID']
          ..name = v['ARRANGEMENT'])
        .toList();
  }
}
