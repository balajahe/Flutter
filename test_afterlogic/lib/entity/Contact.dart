enum ContactType { personal, team }

class Contact {
  ContactType type;
  String uuid = '';
  String etag = '';
  String email = '';
  String name = '';
  String phone = '';
  String address = '';
  String skype = '';
  String facebook = '';
}
