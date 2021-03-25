import 'AbstractRef.dart';

class Position extends AbstractRef {
  int num;
  String roll;
  String batch;
  String dimensions;
  double quantity;

  @override
  Map toMap() {
    var m = super.toMap();
    m['num'] = num;
    m['roll'] = roll;
    m['batch'] = batch;
    m['dimensions'] = dimensions;
    m['quantity'] = quantity;
    return m;
  }

  @override
  Position fromMap(Map m) {
    super.fromMap(m);
    num = m['num'];
    roll = m['roll'];
    batch = m['batch'];
    dimensions = m['dimensions'];
    quantity = m['quantity'];
    return this;
  }
}
