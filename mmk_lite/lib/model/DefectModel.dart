import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';
import 'IssueModel.dart';

class DefectState {
  Defect defect;
  bool waiting;
  bool saved;
  String error;

  DefectState(
    this.defect, {
    this.waiting = false,
    this.saved = false,
    this.error = '',
  });
}

class DefectModel extends Cubit<DefectState> {
  Defect _current = Defect();
  DefectState _lastState;

  DefectModel() : super(DefectState(Defect()));

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
      _lastState = DefectState(_current); //обновляем форму
    }
    emit(_lastState); //не обновляем форму
  }

  void addToIssue(IssueModel issueModel) async {
    if (_current.certificate.length * _current.productType.length * _current.defectType.length > 0) {
      emit(DefectState(_current, waiting: true));
      await issueModel.add(_current);
      emit(DefectState(_current, saved: true));
    } else {
      emit(DefectState(_current, error: 'Заполните все поля'));
    }
  }
}
