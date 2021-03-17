import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import 'SessionModel.dart';
import '../entity/Contact.dart';
import '../dao/ContactDao.dart';

class ContactState extends AbstractState<List<Contact>> {
  ContactState(List<Contact> data) : super(data);
}

class ContactModel extends Cubit<ContactState> {
  List<Contact> _data = [];
  SessionModel _sessionModel;
  ContactDao _dao;

  ContactModel(this._sessionModel) : super(ContactState([])..waiting = true) {
    _dao = ContactDao(_sessionModel.dao);
    _load();
  }

  void _load() async {
    _data = await _dao.getAll();
    emit(ContactState(_data));
  }

  void refresh() {
    emit(ContactState(_data)..waiting = true);
    _load();
  }

  void read(Contact contact) async {
    var i = _data.indexOf(contact);
    _data[i] = await _dao.read(contact);
    emit(ContactState(_data));
  }
}
