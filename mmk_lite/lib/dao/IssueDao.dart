import '../entity/Issue.dart';
import 'UserSessionDao.dart';

class IssueDao {
  UserSessionDao _userSessionDao;
  IssueDao(this._userSessionDao);

  Future<void> putNewIssue(Issue issue) async {
    await _userSessionDao.newIssueBox.put('newIssue', issue);
  }

  Issue getNewIssue() => _userSessionDao.newIssueBox.get('newIssue');
}
