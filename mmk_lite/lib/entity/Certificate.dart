import 'package:hive/hive.dart';
import 'AbstractRef.dart';

part 'Certificate.g.dart';

@HiveType(typeId: 20)
class Certificate extends AbstractRef {
  @HiveField(10)
  String order;

  @HiveField(11)
  DateTime date;
}
