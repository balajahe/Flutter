import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/Session.dart';

class SessionDao {
  Future<Session> login(Session session) async {
    var resp = await http.post(
      Uri.parse(session.host + '/?/Api/'),
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

    var res = jsonDecode(resp.body);
    session.authToken = res['Result']['AuthToken'];

    return session;
  }
}
