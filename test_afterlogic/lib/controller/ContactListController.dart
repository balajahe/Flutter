import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Contact.dart';
import '../dao/ContactListDao.dart';

class ContactListState extends AbstractState<List<Contact>> {
  ContactListState(List<Contact> data) : super(data);
}

class ContactListController extends Cubit<ContactListState> {
  List<Contact> _data = [];

  ContactListController() : super(ContactListState([])..waiting = true) {
    _load();
  }

  void _load() async {
    _data = await ContactListDao().getAll();
    emit(ContactListState(_data));
  }
}
