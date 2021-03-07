import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';

class DefectModel extends Cubit<Defect> {
  Defect _current;

  DefectModel() : super(Defect()) {
    _current = Defect();
  }

  void set({
    String productType,
    String notes,
  }) {
    _current.productType = productType ?? _current.productType;
    _current.notes = notes ?? _current.notes;
    emit(_current);
  }
}
