import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/UserSession.dart';

class UserSessionDao {
  Uri _uri;
  String _authToken = '';
  SharedPreferences _localStorage;

  SharedPreferences get localStorage => _localStorage;

  Future<void> login(UserSession user) async {
    _uri = Uri.parse(user.host + '/?/Api/');
    var res = await post({
      'Module': 'Core',
      'Method': 'Login',
      'Parameters': jsonEncode({'Login': user.email, 'Password': user.password}),
    });
    _authToken = res['AuthToken'];
    _localStorage = await SharedPreferences.getInstance();
  }

  Future<dynamic> post(Object req) async {
    print('\n$req');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
    if (_authToken.length > 0) headers['Authorization'] = 'Bearer ' + _authToken;

    var resp = await http.post(_uri, headers: headers, body: req);
    print('\n${resp.body}');
    return jsonDecode(resp.body)['Result'];
  }
}
