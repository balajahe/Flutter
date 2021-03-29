import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../dao/IssueDaoLocal.dart';
import 'UserSessionModel.dart';
import 'AbstractState.dart';

export '../entity/Issue.dart';

enum IssueFormMode { add, view }

class IssueAddState extends AbstractState {
  Issue data;
  IssueAddState(this.data);
}

class IssueAddModel extends Cubit<IssueAddState> {
  final BuildContext _context;
  final IssueFormMode _mode;

  Issue _data;
  IssueDaoLocal _daoRemote;
  IssueDaoLocal _daoLocal;

  IssueAddModel(this._context, this._mode) : super(IssueAddState(Issue())) {
    _daoRemote = IssueDaoLocal(_context.read<UserSessionModel>().dao);
    _daoLocal = IssueDaoLocal(_context.read<UserSessionModel>().dao);
    _data = _daoLocal.getCurrentIssue() ?? Issue();
    emit(IssueAddState(_data));
  }

  Future<void> addDefect(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects.add(v);
    _daoLocal.setCurrentIssue(_data);
    emit(IssueAddState(_data));
  }

  Future<void> setDefect(Defect oldData, Defect newData) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects[_data.defects.indexOf(oldData)] = newData;
    _daoLocal.setCurrentIssue(_data);
    emit(IssueAddState(_data));
  }

  Future<void> delDefect(Defect v) async {
    _data.defects.remove(v);
    _daoLocal.setCurrentIssue(_data);
    emit(IssueAddState(_data));
  }
}
