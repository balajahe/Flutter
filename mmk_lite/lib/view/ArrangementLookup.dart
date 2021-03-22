import '../entity/Arrangement.dart';
import '../model/ArrangementModel.dart';
import 'AbstractRefLookup.dart';

class ArrangementLookup extends AbstractRefLookup<Arrangement, ArrangementModel> {
  @override
  final hint = 'Найти урегулирование...';
}
