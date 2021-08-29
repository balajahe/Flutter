import '../entity/DefectType.dart';
import 'AbstractRefDao.dart';
import 'UserSessionDao.dart';

const _json = [
  {"ID": "1", "NAME_NSI": "плена", "LANG": "ru"},
  {"ID": "2", "NAME_NSI": "плена прокатная", "LANG": "ru"},
  {"ID": "3", "NAME_NSI": "геометрия", "LANG": "ru"},
  {"ID": "4", "NAME_NSI": "раковина", "LANG": "ru"},
  {"ID": "5", "NAME_NSI": "заусенец", "LANG": "ru"},
  {"ID": "6", "NAME_NSI": "коррозия", "LANG": "ru"},
  {"ID": "7", "NAME_NSI": "отпечатки", "LANG": "ru"},
  {"ID": "8", "NAME_NSI": "полосы-линии скольжения", "LANG": "ru"},
];

class DefectTypeDao extends AbstractRefDao {
  DefectTypeDao(UserSessionDao userSessionDao) : super(userSessionDao);

  Future<List<DefectType>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _json
        .map((v) => DefectType()
          ..id = v['ID']
          ..name = v['NAME_NSI'])
        .toList();
  }
}
