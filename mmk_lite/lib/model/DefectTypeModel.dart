import 'package:flutter_bloc/flutter_bloc.dart';

class DefectTypeState {
  List<String> all;
  String filter;
  bool waiting;
  String error;
  DefectTypeState(
    this.all, {
    this.filter = '',
    this.waiting = false,
    this.error = '',
  });
}

class DefectTypeModel extends Cubit<DefectTypeState> {
  List<String> _all = [];
  String _filter = '';

  DefectTypeModel() : super(DefectTypeState([], waiting: true)) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _all = List.from(['Ничего не получается', 'Фатальный недостаток', 'Просто дефект']);
    emit(DefectTypeState(_all));
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(DefectTypeState(
      _all.where((v) => v.toLowerCase().contains(_filter = s.toLowerCase())).toList(),
      filter: _filter,
    ));
  }

  void clearFilter() {
    if (_filter.length > 0) filter('');
  }
}
