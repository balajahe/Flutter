import 'Item.dart';

class ItemDao {
  static Future<List<Item>> getAll() async {
    await Future.delayed(Duration(seconds: 3));
    return _items;
  }
}

List<Item> _items = [
  Item('Быть или', 'не быть, вот в чем вопрос'),
  Item('Жить в обществе', 'и быть свободным от общества нельзя'),
  Item('Прожить надо так',
      'чтобы не было мучительно больно за бесцельно прожитые годы'),
  Item('Разум это мечь', 'который способен отделить правду от лжи'),
];
