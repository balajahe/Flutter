import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/DefectType.dart';
import '../dao/DefectTypeDao.dart';

class DefectTypeState extends AbstractState {
  List<DefectType> data;
  DefectTypeState(this.data);
}

class DefectTypeModel extends Cubit<DefectTypeState> {
  List<DefectType> _all = [];
  String _filter = '';

  DefectTypeModel() : super(DefectTypeState([])..waiting = true) {
    _load();
  }

  void _load() async {
    _all = await DefectTypeDao().getAll();
    emit(DefectTypeState(_all));
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(DefectTypeState(_all.where((v) => v.name.toLowerCase().contains(_filter)).toList())..filter = _filter);
  }

  void clearFilter() {
    if (_filter.length > 0) filter('');
  }
}
