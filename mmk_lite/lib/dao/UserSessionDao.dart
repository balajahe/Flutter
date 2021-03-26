import 'package:http/http.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/UserSession.dart';

const _url = 'http://module.hq.corp.mmk.chel.su:9090/api/';

class UserSessionDao {
  Box<Map> _currentIssueBox;

  get currentIssueBox => _currentIssueBox;

  Future<void> login(UserSession userSession) async {
    await Hive.initFlutter();
    _currentIssueBox = await Hive.openBox<Map>('currentIssueBox');
  }
}
