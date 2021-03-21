import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import 'UserSessionModel.dart';
import '../entity/DefectType.dart';
import '../dao/DefectTypeDao.dart';

class DefectTypeState extends AbstractState {
  List<DefectType> data;
  DefectTypeState(this.data);
}

class DefectTypeModel extends Cubit<DefectTypeState> {
  List<DefectType> _data = [];
  UserSessionModel _userSessionModel;
  DefectTypeDao _dao;

  DefectTypeModel(this._userSessionModel) : super(DefectTypeState([])..waiting = true) {
    _dao = DefectTypeDao(_userSessionModel.dao);
    _load();
  }

  void _load() async {
    _data = await _dao.getAll();
    emit(DefectTypeState(_data));
  }

  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(DefectTypeState(_data.where((v) => v.name.toLowerCase().contains(_filter)).toList()));
  }

  void clearFilter() {
    if (_data.length > 0) filter('');
  }
}
