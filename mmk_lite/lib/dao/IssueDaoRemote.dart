import '../entity/Issue.dart';
import '../entity/Defect.dart';
import '../entity/DefectType.dart';
import 'UserSessionDao.dart';

class IssueDaoRemote {
  UserSessionDao _userSessionDao;
  IssueDaoRemote(this._userSessionDao);

  Future<List<Issue>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Issue()
        ..id = '1'
        ..date = DateTime.now()
        ..defects = [
          Defect()
            ..productType = 'Прокат листовой травленый'
            ..weightDefect = 0.5
            ..defectType = (DefectType()
              ..id = '1'
              ..name = 'плена'),
          Defect()
            ..productType = 'Прокат г/к листовой травленый'
            ..weightDefect = 0.7
            ..defectType = (DefectType()
              ..id = '3'
              ..name = 'геометрия')
        ],
      Issue()
        ..id = '2'
        ..date = DateTime.now()
        ..defects = [
          Defect()
            ..productType = 'Прокат листовой травленый'
            ..weightDefect = 3.2
            ..defectType = (DefectType()
              ..id = '4'
              ..name = 'раковина'),
          Defect()
            ..productType = 'Прокат г/к листовой травленый'
            ..weightDefect = 1.1
            ..defectType = (DefectType()
              ..id = '5'
              ..name = 'заусенец')
        ]
    ];
  }
}
