import 'dart:convert';

import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import 'DaoSession.dart';

class ContactDao {
  DaoSession _daoSession;
  ContactDao(this._daoSession);

  Future<List<ContactStorage>> getStorages() async {
    var res = await _daoSession.post({
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
    var res = await _daoSession.post({
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

  Future<Contact> getOne(ContactStorage storage, Contact contact) async {
    var res = await _daoSession.post({
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
    return contact;
  }
}
