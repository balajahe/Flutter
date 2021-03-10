import 'package:flutter_bloc/flutter_bloc.dart';

import 'Issue.dart';
import 'Defect.dart';

class IssueModel extends Cubit<Issue> {
  Issue _current = Issue();

  IssueModel() : super(Issue());

  Future<void> add(Defect v) async {
    await Future.delayed(Duration(seconds: 1));
    _current.defects.add(v);
    emit(_current.clone());
  }

  void del(Defect v) {
    _current.defects.remove(v);
    emit(_current.clone());
  }
}
