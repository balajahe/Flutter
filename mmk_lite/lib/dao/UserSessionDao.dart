import '../entity/UserSession.dart';
import 'package:http/http.dart';

const _url = 'http://module.hq.corp.mmk.chel.su:9090/api/';

class UserSessionDao {
  Future<void> login(UserSession userSession) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
