import '../entity/Position.dart';
import 'AbstractRefDao.dart';
import 'UserSessionDao.dart';

class PositionDao extends AbstractRefDao {
  PositionDao(UserSessionDao userSessionDao) : super(userSessionDao);

  Future<List<Position>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Position()
        ..id = '1'
        ..name = 'рулон1'
        ..num = 1
        ..roll = 'рулон1'
        ..batch = '001'
        ..dimensions = '12x144'
        ..quantity = 123.11,
      Position()
        ..id = '2'
        ..name = 'рулон2'
        ..num = 2
        ..roll = 'рулон2'
        ..batch = '005'
        ..dimensions = '111x11'
        ..quantity = 34543543.11,
      Position()
        ..id = '3'
        ..name = 'рулон3'
        ..num = 3
        ..roll = 'рулон3'
        ..batch = '011'
        ..dimensions = '8x15'
        ..quantity = 0.123,
    ];
  }
}
