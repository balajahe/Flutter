import '../entity/AbstractRef.dart';
import 'UserSessionDao.dart';

abstract class AbstractRefDao<T extends AbstractRef> {
  UserSessionDao userSessionDao;
  AbstractRefDao(this.userSessionDao);

  Future<List<T>> getAll();
}
