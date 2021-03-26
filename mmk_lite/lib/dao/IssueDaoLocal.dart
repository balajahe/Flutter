import '../entity/Issue.dart';
import 'UserSessionDao.dart';

class IssueDaoLocal {
  UserSessionDao _userSessionDao;

  IssueDaoLocal(this._userSessionDao);

  Future<void> putCurrentIssue(Issue issue) async {
    await _userSessionDao.currentIssueBox.put('currentIssue', issue.toMap());
  }

  Issue getCurrentIssue() {
    var issueMap = _userSessionDao.currentIssueBox.get('currentIssue');
    return (issueMap != null) ? Issue().fromMap(issueMap) : null;
  }
}
