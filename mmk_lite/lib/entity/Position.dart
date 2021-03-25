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
    m.addAll({
      'num': num,
      'roll': roll,
      'batch': batch,
      'dimensions': dimensions,
      'quantity': quantity,
    });
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
