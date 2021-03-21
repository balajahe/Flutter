import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/entity/DefectType.dart';

import 'AbstractState.dart';
import '../entity/Defect.dart';
import 'IssueModel.dart';

class DefectState extends AbstractState {
  Defect data;
  DefectState(this.data);
}

class DefectModel extends Cubit<DefectState> {
  Defect _current = Defect();
  DefectState _lastState;

  DefectModel() : super(DefectState(Defect()));

  void set({
    String certificate,
    String position,
    String productType,
    DefectType defectType,
    double marriageWeight,
    String notes,
  }) {
    _current.certificate = certificate ?? _current.certificate;
    _current.position = position ?? _current.position;
    _current.productType = productType ?? _current.productType;
    _current.defectType = defectType ?? _current.defectType;
    _current.marriageWeight = marriageWeight ?? _current.marriageWeight;
    _current.notes = notes ?? _current.notes;

    if (certificate != null || position != null || defectType != null) {
      _lastState = DefectState(_current); //обновляем форму
    }
    emit(_lastState); //не обновляем форму
  }

  void addImage(Uint8List image) {
    _current.images.add(image);
    emit(DefectState(_current));
  }

  void addToIssue(IssueModel issueModel) async {
    if (_current.certificate.length * _current.productType.length * _current.defectType.name.length > 0) {
      emit(DefectState(_current)..waiting = true);
      await issueModel.add(_current);
      emit(DefectState(_current)..done = true);
    } else {
      emit(DefectState(_current)..userError = 'Заполните все поля!');
    }
  }
}
