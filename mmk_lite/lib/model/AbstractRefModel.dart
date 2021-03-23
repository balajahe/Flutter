import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import 'UserSessionModel.dart';
import '../entity/AbstractRef.dart';
import '../dao/AbstractRefDao.dart';
import '../dao/UserSessionDao.dart';

class RefState<T1 extends AbstractRef> extends AbstractState {
  List<T1> data;
  RefState(this.data);
}

abstract class AbstractRefModel<T1 extends AbstractRef> extends Cubit<RefState<T1>> {
  BuildContext context;
  AbstractRefDao Function(UserSessionDao) daoCreate;
  @protected
  List<T1> data;
  UserSessionModel _userSessionModel;
  AbstractRefDao _dao;

  AbstractRefModel(this.context, {this.daoCreate}) : super(RefState([])..waiting = true) {
    data = [];
    _userSessionModel = context.read<UserSessionModel>();
    _dao = daoCreate(_userSessionModel.dao);
    _load();
  }

  void _load() async {
    data = await _dao.getAll();
    emit(RefState(data));
  }

  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(RefState(data.where((v) => v.name.toLowerCase().contains(_filter)).toList()));
  }

  void clearFilter() {
    if (data.length > 0) filter(''); //условие необходимо, чтобы отображалась начальная загрузка
  }
}
