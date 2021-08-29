// Интерфейс DAO-объекта

import 'Curr.dart';

abstract class CurrDaoAbstract {
  Future<List<Curr>> getAll(DateTime date);
}
