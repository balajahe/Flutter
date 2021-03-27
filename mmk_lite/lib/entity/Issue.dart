import 'Defect.dart';

export 'Defect.dart';

class Issue {
  String id = '';
  DateTime date;
  List<Defect> defects = [];

  String defectTypes() {
    var s = defects.map((d) => d.defectType.name).toString();
    return s.substring(1, s.length - 1);
  }

  double weightDefects() => defects.fold(0, (s, d) => s += d.weightDefect);

  Map toMap() => {
        'defects': defects.map((d) => d.toMap()).toList(),
      };

  Issue fromMap(Map m) {
    defects = m['defects'].map<Defect>((d) => Defect().fromMap(d)).toList();
    return this;
  }
}
