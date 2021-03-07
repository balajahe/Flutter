import 'package:flutter_bloc/flutter_bloc.dart';

import 'Defect.dart';

class DefectModel extends Cubit<Defect> {
  Defect _defect;

  DefectModel() : super(Defect()) {
    _defect = Defect();
  }
}
