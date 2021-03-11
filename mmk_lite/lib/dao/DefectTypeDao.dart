import '../model/DefectType.dart';

const json = [
  {"ID": "1", "NAME_NSI": "sliver", "LANG": "en"},
  {"ID": "1", "NAME_NSI": "плена", "LANG": "ru"},
  {"ID": "2", "NAME_NSI": "rolled skin / surface lamellation", "LANG": "en"},
  {"ID": "2", "NAME_NSI": "плена прокатная", "LANG": "ru"},
  {"ID": "3", "NAME_NSI": "shape", "LANG": "en"},
  {"ID": "3", "NAME_NSI": "геометрия", "LANG": "ru"},
  {"ID": "4", "NAME_NSI": "cavity", "LANG": "en"},
  {"ID": "4", "NAME_NSI": "раковина", "LANG": "ru"},
  {"ID": "5", "NAME_NSI": "fin", "LANG": "en"},
  {"ID": "5", "NAME_NSI": "заусенец", "LANG": "ru"},
  {"ID": "6", "NAME_NSI": "corrosion", "LANG": "en"},
  {"ID": "6", "NAME_NSI": "коррозия", "LANG": "ru"},
  {"ID": "7", "NAME_NSI": "roll marks", "LANG": "en"},
  {"ID": "7", "NAME_NSI": "отпечатки", "LANG": "ru"},
  {"ID": "8", "NAME_NSI": "guide marks", "LANG": "en"},
  {"ID": "8", "NAME_NSI": "полосы-линии скольжения", "LANG": "ru"},
  {"ID": "9", "NAME_NSI": "nonflatness", "LANG": "en"}
];

class DefectTypeDao {
  Future<List<DefectType>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return json
        .map((v) => DefectType()
          ..id = int.parse(v['ID'])
          ..name = v['NAME_NSI'])
        .toList();
  }
}
