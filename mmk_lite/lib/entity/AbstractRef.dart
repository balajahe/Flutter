import 'package:hive/hive.dart';

@HiveType(typeId: 0)
abstract class AbstractRef {
  @HiveField(0)
  String id = '';

  @HiveField(1)
  String name = '';
}
