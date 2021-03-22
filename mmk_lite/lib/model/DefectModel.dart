import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmk_lite/entity/Certificate.dart';
import 'package:mmk_lite/entity/Position.dart';

import '../entity/Defect.dart';
import '../entity/DefectType.dart';
import '../entity/Arrangement.dart';
import 'AbstractState.dart';
import 'IssueModel.dart';

class DefectState extends AbstractState {
  Defect data;
  DefectState(this.data);
}

class DefectModel extends Cubit<DefectState> {
  Defect _data = Defect();
  DefectState _lastState;

  DefectModel() : super(DefectState(Defect()));

  void set({
    Certificate certificate,
    Position position,
    String productType,
    DefectType defectType,
    double marriageWeight,
    Arrangement arrangement,
    String notes,
  }) {
    _data.certificate = certificate ?? _data.certificate;
    _data.position = position ?? _data.position;
    _data.productType = productType ?? _data.productType;
    _data.defectType = defectType ?? _data.defectType;
    _data.marriageWeight = marriageWeight ?? _data.marriageWeight;
    _data.arrangement = arrangement ?? _data.arrangement;
    _data.notes = notes ?? _data.notes;

    if (certificate != null || position != null || defectType != null || arrangement != null) {
      _lastState = DefectState(_data); //обновляем форму
    }
    emit(_lastState); //не обновляем форму
  }

  void addImage(Uint8List image) {
    _data.images.add(image);
    emit(DefectState(_data));
  }

  void addToIssue(IssueModel issueModel) async {
    if (_data.certificate.id.length *
            _data.position.id.length *
            _data.productType.length *
            _data.defectType.id.length *
            _data.arrangement.id.length >
        0) {
      emit(DefectState(_data)..waiting = true);
      await issueModel.add(_data);
      emit(DefectState(_data)..done = true);
    } else {
      emit(DefectState(_data)..userError = 'Заполните все поля!');
    }
  }
}
