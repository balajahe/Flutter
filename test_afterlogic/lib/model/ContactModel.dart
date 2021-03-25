import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import 'UserSessionModel.dart';
import '../entity/Contact.dart';
import '../entity/ContactStorage.dart';
import '../dao/ContactDaoLocal.dart';
import '../dao/ContactDaoRemote.dart';

class ContactState extends AbstractState {
  List<ContactStorage> storages = [];
  ContactStorage currentStorage = ContactStorage();
  List<Contact> selectedContacts = [];

  ContactState(this.storages, this.currentStorage, this.selectedContacts);
}

class ContactModel extends Cubit<ContactState> {
  BuildContext context;
  List<ContactStorage> _storages = [];
  List<ContactStorage> _storagesLocal = [];
  ContactStorage _currentStorage;
  ContactDaoLocal _daoLocal;
  ContactDaoRemote _daoRemote;
  Timer _localSavingTimer;

  ContactModel(this.context) : super(ContactState([], ContactStorage(), [])..waiting = true) {
    var daoSession = context.read<UserSessionModel>().dao;
    _daoLocal = ContactDaoLocal(daoSession);
    _daoRemote = ContactDaoRemote(daoSession);
    _load();
  }

  Future<void> _load() async {
    _localSavingTimer?.cancel();
    _storages = await _daoRemote.getStorages();
    await setStorage(_currentStorage ?? _storages[0]);
    _localSavingTimer = Timer.periodic(Duration(seconds: 1), (_) => _daoLocal.save(_storages));
  }

  Future<void> setStorage(ContactStorage storage) async {
    emit(ContactState([], ContactStorage(), [])..waiting = true);
    _currentStorage = storage;
    _storagesLocal = await _daoLocal.load();

    try {
      var sl = _storagesLocal.firstWhere((sl) =>
          sl.id == _currentStorage.id && sl.ctag == _currentStorage.ctag && _currentStorage.contacts.length > 0);
      _currentStorage.contacts = sl.contacts;
    } catch (_) {
      print('STORAGE INVALIDATE - ${_currentStorage.id}');
      await _daoRemote.getContacts(_currentStorage);
      var newContacts = <Contact>[];
      _currentStorage.contacts.forEach((cr) {
        try {
          var cl = _currentStorage.contacts.firstWhere((cl) => cl.uuid == cr.uuid && cl.etag == cr.etag);
          newContacts.add(cl);
        } catch (_) {
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
    await _load();
  }
}
