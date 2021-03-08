import 'package:flutter_bloc/flutter_bloc.dart';

class DefectTypeState {
  List<String> all = [];
  String filter = '';
  bool waiting = false;
  String error;
}

class DefectTypeModel extends Cubit<DefectTypeState> {
  List<String> _all = [];
  String _filter = '';

  DefectTypeModel() : super(DefectTypeState()) {
    _load();
  }

  void _load() async {
    emit(DefectTypeState()..waiting = true);
    await Future.delayed(Duration(seconds: 1));
    _all = List.from(['Ничего не получается', 'Фатальный недостаток', 'Просто дефект']);
    emit(DefectTypeState()..all = _all);
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(DefectTypeState()
      ..filter = _filter
      ..all = _all.where((v) => v.toLowerCase().contains(_filter = s.toLowerCase())).toList());
  }
}
