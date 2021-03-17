import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/Contact.dart';
import '../entity/Session.dart';

class ContactListDao {
  Session session;
  ContactListDao({this.session});

  Future<List<Contact>> getAll() async {
    var uri = Uri.parse(session.host + '/?/Api/');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Authorization': 'Bearer ' + session.authToken,
    };

    var resp = await http.post(
      uri,
      headers: headers,
      body: {
        'Module': 'Contacts',
        'Method': 'GetContactStorages',
      },
    );
    print(resp.body);

    var res = jsonDecode(resp.body);
    var stor = res['Result'][0]['Id'];
    print(stor);

    resp = await http.post(
      uri,
      headers: headers,
      body: {
        'Module': 'Contacts',
        'Method': 'GetContactsInfo',
        'Parameters': '{"Storage": "${stor}"}',
      },
    );
    print(resp.body);
    res = jsonDecode(resp.body);

    return res['Result']['Info']
        .map<Contact>((v) => Contact()
          ..type = ContactType.personal
          ..uuid = v['UUID']
          ..etag = v['ETag'])
        .toList();
  }
}
