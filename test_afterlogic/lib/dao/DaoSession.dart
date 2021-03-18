import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/User.dart';

class DaoSession {
  Uri _uri;
  String _authToken = '';

  Future<void> login(User session) async {
    _uri = Uri.parse(session.host + '/?/Api/');
    var res = await post({
      'Module': 'Core',
      'Method': 'Login',
      'Parameters': jsonEncode({'Login': session.email, 'Password': session.password}),
    });
    _authToken = res['AuthToken'];
  }

  Future<dynamic> post(Object req) async {
    print('\n$req');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
    if (_authToken.length > 0) headers['Authorization'] = 'Bearer ' + _authToken;

    var resp = await http.post(_uri, headers: headers, body: req);
    print(resp.body);
    return jsonDecode(resp.body)['Result'];
  }
}
