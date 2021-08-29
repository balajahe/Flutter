import '../entity/DefectType.dart';
import '../model/DefectTypeModel.dart';
import '../view/AbstractRefLookup.dart';

class DefectTypeLookup extends AbstractRefLookup<DefectType, DefectTypeModel> {
  @override
  final hint = 'Найти дефект...';
}
