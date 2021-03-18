import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import '../dao/SessionDao.dart';
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
  SessionDao _sessionDao;
  ContactDao _dao;

  ContactModel(this._sessionDao) : super(ContactState([], ContactStorage(), [])..waiting = true) {
    _dao = ContactDao(_sessionDao);
    _load();
  }

  Future<void> _load() async {
    _storages = await _dao.getStorages();
    await setStorage(_storages[0]);
    emit(ContactState(_storages, _storage, _storage.contacts));
  }

  Future<void> setStorage(ContactStorage storage) async {
    _storage = storage;
    emit(ContactState(_storages, _storage, [])..waiting = true);
    await _dao.getContacts(_storage);
    emit(ContactState(_storages, _storage, _storage.contacts));
  }

  Future<void> refreshAll() async {
    _storages = [];
    _storage = ContactStorage();
    emit(ContactState(_storages, _storage, [])..waiting = true);
    await _load();
  }

  void loadContact(Contact contact) async {
    await _dao.loadContact(_storage, contact);
    emit(ContactState(_storages, _storage, _storage.contacts));
  }
}
