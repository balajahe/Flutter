import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Defect.dart';
import '../entity/Certificate.dart';
import '../entity/Position.dart';
import '../entity/DefectType.dart';
import '../entity/Arrangement.dart';
import 'AbstractState.dart';
import 'IssueModel.dart';

class DefectState extends AbstractState {
  Defect data;
  DefectState(this.data);
}

enum AddEditMode { add, edit }

class DefectModel extends Cubit<DefectState> {
  final BuildContext _context;
  final AddEditMode _mode;
  final Defect _oldData;
  Defect _data;

  DefectModel(this._context, this._mode, this._oldData) : super(DefectState(Defect())) {
    _data = (_mode == AddEditMode.add) ? Defect() : _oldData.clone();
    emit(DefectState(_data));
  }

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
      emit(DefectState(_data));
    }
  }

  void addImage(Uint8List image) {
    _data.images.add(image);
    emit(DefectState(_data));
  }

  Future<void> save() async {
    var issueModel = _context.read<IssueModel>();
    if (_data.certificate.id.length *
            _data.position.id.length *
            _data.productType.length *
            _data.defectType.id.length *
            _data.arrangement.id.length ==
        0) {
      emit(DefectState(_data)..userError = 'Заполните все поля!');
    } else {
      emit(DefectState(_data)..waiting = true);
      if (_mode == AddEditMode.add) {
        await issueModel.add(_data);
        emit(DefectState(_data)..done = true);
      } else if (_mode == AddEditMode.edit) {
        await issueModel.replace(_oldData, _data);
        emit(DefectState(_data)..done = true);
      }
    }
  }
}
