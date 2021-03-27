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
            ..weightDefect = 0.5
            ..defectType = (DefectType()
              ..id = '1'
              ..name = 'плена'),
          Defect()
            ..weightDefect = 0.5
            ..defectType = (DefectType()
              ..id = '3'
              ..name = 'геометрия')
        ]
    ];
  }
}
