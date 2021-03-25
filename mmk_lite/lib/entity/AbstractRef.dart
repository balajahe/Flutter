import 'package:hive/hive.dart';

part 'AbstractRef.g.dart';

@HiveType(typeId: 0)
class AbstractRef {
  @HiveField(0)
  String id = '';

  @HiveField(1)
  String name = '';
}
