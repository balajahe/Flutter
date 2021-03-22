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

  void del(Defect v) {
    _data.defects.remove(v);
    emit(IssueState(_data));
  }
}
