import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/UserSession.dart';

const _url = 'http://module.hq.corp.mmk.chel.su:9090/api/';

class UserSessionDao {
  SharedPreferences _localStorage;

  SharedPreferences get localStorage => _localStorage;

  Future<void> login(UserSession userSession) async {
    _localStorage = await SharedPreferences.getInstance();
  }
}
