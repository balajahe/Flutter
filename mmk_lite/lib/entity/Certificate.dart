import 'AbstractRef.dart';

class Certificate extends AbstractRef {
  String order;
  DateTime date;

  @override
  Map toMap() {
    var m = super.toMap();
    m.addAll({
      'order': order,
      'date': date.toIso8601String(),
    });
    return m;
  }

  @override
  Certificate fromMap(Map m) {
    super.fromMap(m);
    order = m['order'];
    date = DateTime.parse(m['date']);
    return this;
  }
}
