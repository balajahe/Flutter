import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/Contact.dart';
import 'SessionDao.dart';

class ContactDao {
  SessionDao _sessionDao;
  ContactDao(this._sessionDao);

  Future<List<Contact>> getAll() async {
    var resp = await http.post(
      _sessionDao.uri,
      headers: _headers,
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
      _sessionDao.uri,
      headers: _headers,
      body: {
        'Module': 'Contacts',
        'Method': 'GetContactsInfo',
        'Parameters': '{"Storage": "${stor}"}',
      },
    );
    print(resp.body);
    res = jsonDecode(resp.body)['Result']['Info'];
    return res
        .map<Contact>((v) => Contact()
          ..type = ContactType.personal
          ..uuid = v['UUID']
          ..etag = v['ETag'])
        .toList();
  }

  Future<Contact> read(Contact contact) async {
    var resp = await http.post(
      _sessionDao.uri,
      headers: _headers,
      body: {
        'Module': 'Contacts',
        'Method': 'GetContactsByUids',
        'Parameters': '{"Storage": "personal", "Uids":["${contact.uuid}"]}',
      },
    );
    print(resp.body);
    var res = jsonDecode(resp.body)['Result'][0];
    contact
      ..email = res['PersonalEmail']
      ..name = res['FullName']
      ..phone = res['PersonalPhone']
      ..address = res['PersonalAddress'].toString()
      ..skype = res['Skype']
      ..facebook = res['Facebook'];
    return contact;
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Authorization': 'Bearer ' + _sessionDao.authToken,
      };
}
