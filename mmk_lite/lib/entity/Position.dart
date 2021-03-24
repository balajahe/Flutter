import 'package:hive/hive.dart';
import 'AbstractRef.dart';

@HiveType(typeId: 4)
class Position extends AbstractRef {
  int num;
  String roll;
  String batch;
  String dimensions;
  double quantity;
}
