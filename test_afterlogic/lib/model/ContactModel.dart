import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import '../dao/SessionDao.dart';
import '../dao/ContactDaoLocal.dart';
import '../dao/ContactDaoRemote.dart';

class ContactStateData {
  List<ContactStorage> storages = [];
  ContactStorage currentStorage = ContactStorage();
  List<Contact> selectedContacts = [];

  ContactStateData(this.storages, this.currentStorage, this.selectedContacts);
}

class ContactState extends AbstractState<ContactStateData> {
  ContactState(
    List<ContactStorage> storages,
    ContactStorage currentStorage,
    List<Contact> selectedContacts,
  ) : super(ContactStateData(storages, currentStorage, selectedContacts));
}

class ContactModel extends Cubit<ContactState> {
  List<ContactStorage> _storages = [];
  List<ContactStorage> _storagesLocal = [];
  ContactStorage _currentStorage;
  SessionDao _sessionDao;
  ContactDaoLocal _daoLocal;
  ContactDaoRemote _daoRemote;
  Timer _localSavingTimer;

  ContactModel(this._sessionDao) : super(ContactState([], ContactStorage(), [])..waiting = true) {
    _daoLocal = ContactDaoLocal(_sessionDao);
    _daoRemote = ContactDaoRemote(_sessionDao);
    _load();
  }

  Future<void> _load() async {
    _localSavingTimer?.cancel();
    _storages = await _daoRemote.getStorages();
    _storagesLocal = await _daoLocal.load();
    await setStorage(_storages[0]);
    _localSavingTimer = Timer.periodic(Duration(seconds: 3), (_) => _daoLocal.save(_storages));
  }

  Future<void> setStorage(ContactStorage storage) async {
    _currentStorage = storage;
    emit(ContactState([], ContactStorage(), [])..waiting = true);

    try {
      var sl = _storagesLocal.firstWhere((sl) => sl.id == _currentStorage.id && sl.ctag == _currentStorage.ctag);
      _currentStorage.contacts = sl.contacts;
    } catch (e) {
      print('STORAGE INVALIDATE - ${_currentStorage.id}');
      await _daoRemote.getContacts(_currentStorage);
      var newContacts = <Contact>[];
      _currentStorage.contacts.forEach((cr) {
        try {
          var cl = _currentStorage.contacts.firstWhere((cl) => cl.uuid == cr.uuid && cl.etag == cr.etag);
          newContacts.add(cl);
        } catch (e) {
          print('CONTACT INVALIDATE - ${cr.email}');
          newContacts.add(cr);
        }
      });
      _currentStorage.contacts = newContacts;
    }

    emit(ContactState(_storages, _currentStorage, _currentStorage.contacts));
  }

  Future<void> loadContact(Contact contact) async {
    await _daoRemote.loadContact(_currentStorage, contact);
    emit(ContactState(_storages, _currentStorage, _currentStorage.contacts));
  }

  Future<void> refresh() async {
    _localSavingTimer?.cancel();
    emit(ContactState([], ContactStorage(), [])..waiting = true);
    await _load();
  }

  Future<void> reload() async {
    _localSavingTimer?.cancel();
    emit(ContactState([], ContactStorage(), [])..waiting = true);
    await _daoLocal.clear();
    await refresh();
  }
}
