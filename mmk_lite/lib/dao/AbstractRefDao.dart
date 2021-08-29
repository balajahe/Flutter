import 'package:meta/meta.dart';

import '../entity/AbstractRef.dart';
import 'UserSessionDao.dart';

abstract class AbstractRefDao<T extends AbstractRef> {
  @protected
  UserSessionDao userSessionDao;

  AbstractRefDao(this.userSessionDao);

  Future<List<T>> getAll();
}
