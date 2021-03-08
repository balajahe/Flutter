import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';

class DefectModel extends Cubit<Defect> {
  Defect _current;

  DefectModel() : super(Defect()) {
    _current = Defect();
  }

  void set({
    String certificate,
    String position,
    String productType,
    String defect,
    String notes,
  }) {
    _current.certificate = certificate ?? _current.certificate;
    _current.position = position ?? _current.position;
    _current.productType = productType ?? _current.productType;
    _current.defect = defect ?? _current.defect;
    _current.notes = notes ?? _current.notes;

    if (certificate != null || position != null || defect != null)
      emit(_current.clone());
    else
      emit(_current);
  }
}
