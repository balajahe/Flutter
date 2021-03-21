import 'Defect.dart';

class Issue {
  List<Defect> defects = [];

  Issue clone() => Issue()..defects = List.from(defects);
}
