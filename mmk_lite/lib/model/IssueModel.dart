import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Issue.dart';
import '../entity/Defect.dart';
import 'AbstractState.dart';

class IssueState extends AbstractState {
  Issue data;
  IssueState(this.data);
}

class IssueModel extends Cubit<IssueState> {
  Issue _data = Issue();

  IssueModel() : super(IssueState(Issue()));

  Future<void> add(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects.add(v);
    emit(IssueState(_data));
  }

  Future<void> replace(Defect oldData, Defect newData) async {
    await Future.delayed(Duration(seconds: 1));
    _data.defects[_data.defects.indexOf(oldData)] = newData;
    emit(IssueState(_data));
  }

  Future<void> del(Defect v) async {
    _data.defects.remove(v);
    emit(IssueState(_data));
  }
}
