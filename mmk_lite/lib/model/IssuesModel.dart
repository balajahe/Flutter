import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../dao/IssueDaoRemote.dart';
import 'UserSessionModel.dart';
import 'AbstractState.dart';

export '../entity/Issue.dart';

class IssuesState extends AbstractState {
  List<Issue> data;
  IssuesState(this.data);
}

class IssuesModel extends Cubit<IssuesState> {
  List<Issue> _data = [];
  IssueDaoRemote _dao;

  IssuesModel(BuildContext context) : super(IssuesState([])..waiting = true) {
    _dao = IssueDaoRemote(context.read<UserSessionModel>().dao);
    _load();
  }

  Future<void> _load() async {
    _data = await _dao.getAll();
    emit(IssuesState(_data));
  }

  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(IssuesState(_data.where((v) => v.id.toLowerCase().contains(_filter)).toList()));
  }

  void clearFilter() {
    if (_data.length > 0) filter('');
  }
}
