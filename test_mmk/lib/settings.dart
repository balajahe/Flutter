import 'model/CurrDaoAbstract.dart';
import 'model/CurrDaoCbr.dart';

// id выбранных валют
final currSelected = ['R01235', 'R01239', 'R01090B', 'R01335'];

// синглтон DAO-объекта, простейшее внедрение зависимостей
CurrDaoAbstract _currDaoInstance;

CurrDaoAbstract get currDaoInstance {
  if (_currDaoInstance == null) _currDaoInstance = CurrDaoCbr();
  return _currDaoInstance;
}
