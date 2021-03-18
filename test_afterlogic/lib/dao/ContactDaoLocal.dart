import 'dart:convert';

import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import 'SessionDao.dart';

class ContactDaoLocal {
  SessionDao _sessionDao;
  ContactDaoLocal(this._sessionDao);

  Future<void> save(List<ContactStorage> storages) async {
    var map = storages
        .map((s) => {
              'id': s.id,
              'ctag': s.ctag,
              'contacts': s.contacts
                  .map((c) => {
                        'uuid': c.uuid,
                        'etag': c.etag,
                        'email': c.email,
                        'name': c.name,
                        'phone': c.phone,
                        'address': c.address,
                        'skype': c.skype,
                        'facebook': c.facebook
                      })
                  .toList(),
            })
        .toList();
    var res = await _sessionDao.localStorage.setString('allData', jsonEncode(map));
    if (!res) throw 'Local storage writing error!';
  }

  Future<List<ContactStorage>> load() async {
    var json = _sessionDao.localStorage.getString('allData');
    if (json == null) {
      return [];
    } else {
      return jsonDecode(json)
          .map((s) => ContactStorage()
            ..id = s['id']
            ..ctag = s['ctag']
            ..contacts = s['contacts']
                .map((c) => Contact()
                  ..uuid = c['uuid']
                  ..etag = c['etag']
                  ..email = c['email']
                  ..name = c['name']
                  ..phone = c['phone']
                  ..address = c['address']
                  ..skype = c['skype']
                  ..facebook = c['facebook'])
                .toList())
          .toList();
    }
  }
}
