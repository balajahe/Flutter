import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../dao/IssueDaoLocal.dart';
import '../model/UserSessionModel.dart';
import 'AbstractState.dart';

export '../entity/Issue.dart';

class IssueState extends AbstractState {
  Issue data;
  IssueState(this.data);
}

class IssueModel extends Cubit<IssueState> {
  Issue _data;
  IssueDaoLocal _daoRemote;
  IssueDaoLocal _daoLocal;

  IssueModel(BuildContext context) : super(IssueState(Issue())) {
    _daoRemote = IssueDaoLocal(context.read<UserSessionModel>().dao);
    _daoLocal = IssueDaoLocal(context.read<UserSessionModel>().dao);
    _data = _daoLocal.getCurrentIssue() ?? Issue();
    emit(IssueState(_data));
  }

  Future<void> addDefect(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects.add(v);
    _daoLocal.setCurrentIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> setDefect(Defect oldData, Defect newData) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects[_data.defects.indexOf(oldData)] = newData;
    _daoLocal.setCurrentIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> delDefect(Defect v) async {
    _data.defects.remove(v);
    _daoLocal.setCurrentIssue(_data);
    emit(IssueState(_data));
  }
}
