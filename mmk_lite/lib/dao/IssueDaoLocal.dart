import 'dart:convert';
import 'dart:typed_data';

import '../entity/Issue.dart';
import '../entity/Defect.dart';
import 'UserSessionDao.dart';

class IssueDaoLocal {
  UserSessionDao _userSessionDao;

  IssueDaoLocal(this._userSessionDao) {
    _userSessionDao.localStorage.clear();
  }

  Future<void> putCurrentIssue(Issue issue) {
    return _userSessionDao.localStorage.setString('newIssue', jsonEncode(issue.toMap()));
  }

  Issue getCurrentIssue() {
    var json = _userSessionDao.localStorage.getString('newIssue');
    if (json == null)
      return null;
    else
      return Issue().fromMap(jsonDecode(json));
  }
}
