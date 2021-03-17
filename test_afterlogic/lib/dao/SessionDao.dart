import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/Session.dart';

class SessionDao {
  Uri _uri;
  String _authToken;

  Uri get uri => _uri;
  String get authToken => _authToken;

  Future<Session> login(Session session) async {
    _uri = Uri.parse(session.host + '/?/Api/');

    var resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: {
        'Module': 'Core',
        'Method': 'Login',
        'Parameters': '{"Login": "${session.email}", "Password": "${session.password}"}',
      },
    );
    print(resp.body);

    _authToken = jsonDecode(resp.body)['Result']['AuthToken'];

    return session;
  }
}
