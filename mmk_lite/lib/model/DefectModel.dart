import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';
import 'IssueModel.dart';

class DefectState {
  Defect defect;
  bool waiting = false;
  bool saved = false;
  String error = '';
}

class DefectModel extends Cubit<DefectState> {
  Defect _current;
  DefectState _lastState;

  DefectModel() : super(DefectState()..defect = Defect()) {
    _current = Defect();
  }

  void set({
    String certificate,
    String position,
    String productType,
    String defectType,
    String notes,
  }) {
    _current.certificate = certificate ?? _current.certificate;
    _current.position = position ?? _current.position;
    _current.productType = productType ?? _current.productType;
    _current.defectType = defectType ?? _current.defectType;
    _current.notes = notes ?? _current.notes;

    if (certificate != null || position != null || defectType != null) {
      _lastState = DefectState()..defect = _current;
      emit(_lastState);
    } else {
      emit(_lastState);
    }
  }

  void addToIssue(IssueModel issueModel) {
    if (_current.certificate.length * _current.productType.length * _current.defectType.length > 0) {
      issueModel.add(_current);
      emit(DefectState()
        ..defect = _current
        ..saved = true);
    } else {
      emit(DefectState()
        ..defect = _current
        ..error = 'Заполните все поля');
    }
  }
}
