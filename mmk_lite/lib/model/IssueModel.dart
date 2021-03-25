import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../entity/Defect.dart';
import '../dao/IssueDao.dart';
import '../model/UserSessionModel.dart';
import 'AbstractState.dart';

class IssueState extends AbstractState {
  Issue data;
  IssueState(this.data);
}

class IssueModel extends Cubit<IssueState> {
  Issue _data;
  IssueDao _dao;

  IssueModel(BuildContext context) : super(IssueState(Issue())) {
    _dao = IssueDao(context.read<UserSessionModel>().dao);
    _data = _dao.getNewIssue() ?? Issue();
  }

  Future<void> add(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects.add(v);
    _dao.putNewIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> replace(Defect oldData, Defect newData) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects[_data.defects.indexOf(oldData)] = newData;
    _dao.putNewIssue(_data);
    emit(IssueState(_data));
  }

  Future<void> del(Defect v) async {
    _data.defects.remove(v);
    _dao.putNewIssue(_data);
    emit(IssueState(_data));
  }
}
