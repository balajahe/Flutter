import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';

class DefectModel extends Cubit<Defect> {
  Defect _current;

  DefectModel() : super(Defect()) {
    _current = Defect();
  }

  void set({
    String certificate,
    String productType,
    String notes,
  }) {
    _current.certificate = certificate ?? _current.certificate;
    _current.productType = productType ?? _current.productType;
    _current.notes = notes ?? _current.notes;
    if (certificate != null) emit(_current.clone());
  }
}
