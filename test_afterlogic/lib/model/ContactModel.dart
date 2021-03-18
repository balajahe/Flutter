import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import '../dao/DaoSession.dart';
import '../dao/ContactDao.dart';

class ContactStateData {
  List<ContactStorage> storages = [];
  ContactStorage storage = ContactStorage();
  List<Contact> contacts = [];

  ContactStateData(this.storages, this.storage, this.contacts);
}

class ContactState extends AbstractState<ContactStateData> {
  ContactState(
    List<ContactStorage> storages,
    ContactStorage storage,
    List<Contact> contacts,
  ) : super(ContactStateData(storages, storage, contacts));
}

class ContactModel extends Cubit<ContactState> {
  List<ContactStorage> _storages = [];
  ContactStorage _storage;
  DaoSession _daoSession;
  ContactDao _dao;

  ContactModel(this._daoSession) : super(ContactState([], ContactStorage(), [])..waiting = true) {
    _dao = ContactDao(_daoSession);
    _load();
  }

  void _load() async {
    _storages = await _dao.getStorages();
    _storage = _storages[0];
    await refresh();
    emit(ContactState(_storages, _storage, _storage.contacts));
  }

  void setStorage(ContactStorage storage) {
    _storage = storage;
    refresh();
  }

  Future<void> refresh() async {
    emit(ContactState(_storages, _storage, [])..waiting = true);
    await _dao.getContacts(_storage);
    emit(ContactState(_storages, _storage, _storage.contacts));
  }

  void getOne(Contact contact) async {
    var i = _storage.contacts.indexOf(contact);
    _storage.contacts[i] = await _dao.getOne(_storage, contact);
    emit(ContactState(_storages, _storage, _storage.contacts));
  }
}
