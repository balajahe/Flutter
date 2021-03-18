import 'dart:convert';

import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import 'SessionDao.dart';

class ContactDao {
  SessionDao _sessionDao;
  ContactDao(this._sessionDao);

  Future<List<ContactStorage>> getStorages() async {
    var res = await _sessionDao.post({
      'Module': 'Contacts',
      'Method': 'GetContactStorages',
    });
    return res
        .map<ContactStorage>((v) => ContactStorage()
          ..id = v['Id']
          ..ctag = v['CTag'].toString())
        .toList();
  }

  Future<void> getContacts(ContactStorage storage) async {
    var res = await _sessionDao.post({
      'Module': 'Contacts',
      'Method': 'GetContactsInfo',
      'Parameters': jsonEncode({'Storage': storage.id}),
    });
    storage.contacts = res['Info']
        .map<Contact>((v) => Contact()
          ..uuid = v['UUID']
          ..etag = v['ETag'])
        .toList();
  }

  Future<void> loadContact(ContactStorage storage, Contact contact) async {
    var res = await _sessionDao.post({
      'Module': 'Contacts',
      'Method': 'GetContactsByUids',
      'Parameters': jsonEncode({
        'Storage': storage.id,
        'Uids': [contact.uuid]
      }),
    });
    var c = res[0];
    contact
      ..uuid = c['UUID']
      ..etag = c['ETag']
      ..email = c['PersonalEmail']
      ..name = c['FullName']
      ..phone = c['PersonalPhone']
      ..address = c['PersonalAddress']
      ..skype = c['Skype']
      ..facebook = c['Facebook'];
  }
}
