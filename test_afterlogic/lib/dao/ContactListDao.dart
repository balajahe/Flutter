import '../entity/Contact.dart';

class ContactListDao {
  Future<List<Contact>> getAll() async {
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
