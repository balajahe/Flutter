import 'package:http/http.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/UserSession.dart';
import '../entity/Issue.dart';

const _url = 'http://module.hq.corp.mmk.chel.su:9090/api/';

class UserSessionDao {
  Box<Issue> _newIssueBox;

  Future<void> login(UserSession userSession) async {
    await Hive.initFlutter();
    _newIssueBox = await Hive.openBox('testBox');
  }
}
