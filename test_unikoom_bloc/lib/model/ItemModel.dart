import 'package:flutter_bloc/flutter_bloc.dart';

import '../dao/Item.dart';
import '../settings.dart';

class ItemState {
  final List<Item> items;
  final Item selected;
  final String searchString;
  final bool isLoading;

  ItemState(this.items, this.selected, this.searchString, this.isLoading);

  ItemState.blank()
      : items = [],
        selected = null,
        searchString = '',
        isLoading = true;
}

class ItemModel extends Cubit<ItemState> {
  List<Item> _items;
  Item _selected;
  String _searchString;
  bool _isLoading;

  ItemModel() : super(ItemState.blank()) {
    getAll(); //не уверен, что это методологически верно, но работает
  }

  void _emit() => emit(ItemState(
        this._searchString == ''
            ? this._items
            : _items
                .where((el) => el.title.toLowerCase().contains(_searchString))
                .toList(),
        this._selected,
        this._searchString,
        this._isLoading,
      ));

  void getAll() async {
    _items = [];
    _selected = null;
    _searchString = '';
    _isLoading = true;
    _emit();

    _items = await itemDao.getAll();
    _isLoading = false;
    _emit();
  }

  void getWhere(String searchString) {
    _selected = null;
    _searchString = searchString.toLowerCase();
    _emit();
  }

  void select(Item selected) {
    _selected = (selected == _selected) ? null : selected;
    _emit();
  }
}
