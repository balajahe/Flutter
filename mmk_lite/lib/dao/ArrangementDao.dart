import '../entity/Arrangement.dart';
import 'AbstractRefDao.dart';
import 'UserSessionDao.dart';

const _json = [
  {
    "ID": "213",
    "ARRANGEMENT": "Возможно использование без выставления претензии, требуется разработка корректирующих мероприятий",
    "LANG": "ru"
  },
];

class ArrangementDao extends AbstractRefDao {
  ArrangementDao(UserSessionDao userSessionDao) : super(userSessionDao);

  Future<List<Arrangement>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _json
        .map((v) => Arrangement()
          ..id = v['ID']
          ..name = v['ARRANGEMENT'])
        .toList();
  }
}
