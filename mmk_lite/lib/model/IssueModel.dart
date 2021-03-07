import 'package:flutter_bloc/flutter_bloc.dart';

import 'Issue.dart';
import 'Defect.dart';

class IssueModel extends Cubit<Issue> {
  Issue _current;

  IssueModel() : super(Issue()) {
    _current = Issue();
  }

  void add(Defect v) {
    _current.defects.add(v);
    emit(_current.clone());
  }

  void del(Defect v) {
    _current.defects.remove(v);
    emit(_current.clone());
  }
}
