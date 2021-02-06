import 'Item.dart';

abstract class ItemDaoAbstract {
  Future<List<Item>> getAll();
}
