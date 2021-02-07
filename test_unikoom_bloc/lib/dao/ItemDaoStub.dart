import 'Item.dart';
import 'ItemDaoAbstract.dart';

class ItemDaoStub extends ItemDaoAbstract {
  @override
  Future<List<Item>> getAll() async {
    await Future.delayed(Duration(seconds: 2));
    return _items;
  }
}

List<Item> _items = [
  Item('Быть или', 'не быть, вот в чем вопрос'),
  Item('Жить в обществе', 'и быть свободным от общества нельзя'),
  Item('Прожить надо так',
      'чтобы не было мучительно больно за бесцельно прожитые годы'),
  Item('Разум это мечь', 'который способен отделить истину от иллюзии'),
];
