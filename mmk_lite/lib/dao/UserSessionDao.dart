import 'package:http/http.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/AbstractRef.dart';
import '../entity/Arrangement.dart';
import '../entity/Certificate.dart';
import '../entity/Defect.dart';
import '../entity/DefectType.dart';
import '../entity/Issue.dart';
import '../entity/Position.dart';
import '../entity/UserSession.dart';

const _url = 'http://module.hq.corp.mmk.chel.su:9090/api/';

class UserSessionDao {
  Box<Issue> _newIssueBox;

  Box<Issue> get newIssueBox => _newIssueBox;

  Future<void> login(UserSession userSession) async {
    Hive.registerAdapter(ArrangementAdapter());
    Hive.registerAdapter(CertificateAdapter());
    Hive.registerAdapter(DefectAdapter());
    Hive.registerAdapter(DefectTypeAdapter());
    Hive.registerAdapter(IssueAdapter());
    Hive.registerAdapter(PositionAdapter());
    Hive.registerAdapter(UserSessionAdapter());
    Hive.registerAdapter(AbstractRefAdapter());

    await Hive.initFlutter();
    _newIssueBox = await Hive.openBox<Issue>('newIssueBox');
  }
}
