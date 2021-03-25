import 'package:hive/hive.dart';
import 'AbstractRef.dart';

part 'Position.g.dart';

@HiveType(typeId: 60)
class Position extends AbstractRef {
  @HiveField(10)
  int num;

  @HiveField(11)
  String roll;

  @HiveField(12)
  String batch;

  @HiveField(13)
  String dimensions;

  @HiveField(14)
  double quantity;
}
