import 'package:hive/hive.dart';
import 'Defect.dart';

part 'Issue.g.dart';

@HiveType(typeId: 50)
class Issue {
  @HiveField(0)
  String id = '';

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  List<Defect> defects = [];
}
