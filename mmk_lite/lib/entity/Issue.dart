import 'Defect.dart';

class Issue {
  String id = '';
  DateTime date;
  List<Defect> defects = [];

  Map toMap() => {
        'defects': defects.map((d) => d.toMap()).toList(),
      };

  Issue fromMap(Map m) {
    defects = m['defects'].map<Defect>((d) => Defect().fromMap(d)).toList();
    return this;
  }
}
