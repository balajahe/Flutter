import 'package:hive/hive.dart';
import 'AbstractRef.dart';

@HiveType(typeId: 2)
class Certificate extends AbstractRef {
  @HiveField(0)
  String order;

  @HiveField(1)
  DateTime date;
}
