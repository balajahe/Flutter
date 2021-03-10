import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';

class DefectTypeState extends AbstractState<List<String>> {
  DefectTypeState(List<String> data) : super(data);
}

class DefectTypeModel extends Cubit<DefectTypeState> {
  List<String> _all = [];
  String _filter = '';

  DefectTypeModel() : super(DefectTypeState([])..waiting = true) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _all = ['Ничего не получается', 'Фатальный недостаток', 'Просто дефект'];
    emit(DefectTypeState(_all));
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(DefectTypeState(_all.where((v) => v.toLowerCase().contains(_filter)).toList())..filter = _filter);
  }

  void clearFilter() {
    if (_filter.length > 0) filter('');
  }
}
