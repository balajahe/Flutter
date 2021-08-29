import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../dao/IssueDaoRemote.dart';
import 'UserSessionModel.dart';
import 'AbstractState.dart';

export '../entity/Issue.dart';

class IssueListState extends AbstractState {
  List<Issue> data;
  IssueListState(this.data);
}

class IssueListModel extends Cubit<IssueListState> {
  List<Issue> _data = [];
  IssueDaoRemote _dao;

  IssueListModel(BuildContext context) : super(IssueListState([])..waiting = true) {
    _dao = IssueDaoRemote(context.read<UserSessionModel>().dao);
    _load();
  }

  Future<void> _load() async {
    _data = await _dao.getAll();
    emit(IssueListState(_data));
  }

  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(IssueListState(_data.where((v) => v.id.toLowerCase().contains(_filter)).toList()));
  }

  void clearFilter() {
    if (_data.length > 0) filter('');
  }
}
