import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../entity/Defect.dart';
import '../dao/IssueDaoLocal.dart';
import '../model/UserSessionModel.dart';
import 'AbstractState.dart';

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
  }

  Future<void> add(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects.add(v);
    _daoLocal.putCurrentIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> replace(Defect oldData, Defect newData) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects[_data.defects.indexOf(oldData)] = newData;
    _daoLocal.putCurrentIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> del(Defect v) async {
    _data.defects.remove(v);
    _daoLocal.putCurrentIssue(_data);
    emit(IssueState(_data));
  }
}
