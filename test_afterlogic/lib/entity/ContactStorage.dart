import 'Contact.dart';

class ContactStorage {
  String id = '';
  String ctag = '';
  List<Contact> contacts = [];

  // ContactStorage.fromJson(String json) {
  //   var m = jsonDecode(json);
  //   id = m['id'];
  //   ctag = m['ctag'];
  //   contacts = m['contacts']
  //       .map((c) => Contact()
  //         ..uuid = c['uuid']
  //         ..etag = c['etag']
  //         ..email = c['email']
  //         ..name = c['name']
  //         ..phone = c['phone']
  //         ..address = c['address']
  //         ..skype = c['skype']
  //         ..facebook = c['facebook'])
  //       .toList();
  // }

  // String toJson() => jsonEncode({
  //       'id': id,
  //       'ctag': ctag,
  //       'contacts': contacts
  //           .map((v) => {
  //                 'uuid': v.uuid,
  //                 'etag': v.etag,
  //                 'email': v.email,
  //                 'name': v.name,
  //                 'phone': v.phone,
  //                 'address': v.address,
  //                 'skype': v.skype,
  //                 'facebook': v.facebook
  //               })
  //           .toList(),
  //     });
}
