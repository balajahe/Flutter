import 'dao/ItemDaoAbstract.dart';
import 'dao/ItemDaoStub.dart';

//простое внедрение зависимостей

ItemDaoAbstract _itemDao;

ItemDaoAbstract get itemDao {
  if (_itemDao == null) _itemDao = ItemDaoStub();
  return _itemDao;
}
