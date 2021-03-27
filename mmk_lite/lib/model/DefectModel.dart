import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Defect.dart';
import 'AbstractState.dart';
import 'IssueModel.dart';

export '../entity/Defect.dart';

class DefectState extends AbstractState {
  Defect data;
  Defect oldData;
  DefectState(this.data, this.oldData);
}

enum AddEditMode { add, edit }

class DefectModel extends Cubit<DefectState> {
  final BuildContext _context;
  final AddEditMode _mode;
  Defect _oldData;
  Defect _data;

  DefectModel(this._context, this._mode, this._oldData) : super(DefectState(Defect(), Defect())) {
    if (_oldData == null) _oldData = Defect();
    _data = (_mode == AddEditMode.add) ? Defect() : _oldData.clone();
    emit(DefectState(_data, _oldData));
  }

  void set({
    Certificate certificate,
    Position position,
    String productType,
    DefectType defectType,
    double weightDefect,
    Arrangement arrangement,
    String notes,
  }) {
    _data.certificate = certificate ?? _data.certificate;
    _data.position = position ?? _data.position;
    _data.productType = productType ?? _data.productType;
    _data.defectType = defectType ?? _data.defectType;
    _data.weightDefect = weightDefect ?? _data.weightDefect;
    _data.arrangement = arrangement ?? _data.arrangement;
    _data.remark = notes ?? _data.remark;

    if (certificate != null || position != null || defectType != null || arrangement != null) {
      emit(DefectState(_data, _oldData));
    }
  }

  void addFile(DefectFile file) {
    _data.files.add(file);
    emit(DefectState(_data, _oldData));
  }

  Future<void> save() async {
    var issueModel = _context.read<IssueModel>();
    if (_data.certificate.id.length *
            _data.position.id.length *
            _data.productType.length *
            _data.defectType.id.length *
            _data.arrangement.id.length ==
        0) {
      emit(DefectState(_data, _oldData)..userError = 'Заполните все поля!');
    } else {
      emit(DefectState(_data, _oldData)..waiting = true);
      if (_mode == AddEditMode.add) {
        await issueModel.addDefect(_data);
        emit(DefectState(_data, _oldData)..done = true);
      } else if (_mode == AddEditMode.edit) {
        await issueModel.setDefect(_oldData, _data);
        emit(DefectState(_data, _oldData)..done = true);
      }
    }
  }
}
