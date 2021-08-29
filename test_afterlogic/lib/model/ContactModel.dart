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

final _waiting = ContactState([], ContactStorage(), [])..waiting = true;

class ContactModel extends Cubit<ContactState> {
  BuildContext context;
  List<ContactStorage> _storages = [];
  ContactStorage _currentStorage;
  ContactDaoLocal _daoLocal;
  ContactDaoRemote _daoRemote;
  Timer _localSavingTimer;

  ContactModel(this.context) : super(_waiting) {
    var daoSession = context.read<UserSessionModel>().dao;
    _daoLocal = ContactDaoLocal(daoSession);
    _daoRemote = ContactDaoRemote(daoSession);
    _load();
  }

  Future<void> _load() async {
    _localSavingTimer?.cancel();
    _storages = await _daoRemote.getStorages();
    var storagesLocal = await _daoLocal.getStorages();
    _storages.forEach((sr) {
      try {
        var sl = storagesLocal.firstWhere((sl) => sl.id == sr.id && sl.ctag == sr.ctag && sl.contacts.length > 0);
        sr.contacts = sl.contacts;
        sr.isLoaded = true;
      } catch (_) {
        print('STORAGE INVALIDATE - ${sr.id}');
      }
    });
    _daoLocal.putStorages(_storages);
    await setStorage(_storages[0]);
    _localSavingTimer = Timer.periodic(Duration(seconds: 1), (_) => _daoLocal.putStorages(_storages));
  }

  Future<void> setStorage(ContactStorage storage) async {
    emit(_waiting);
    _currentStorage = storage;
    if (!_currentStorage.isLoaded) {
      await _daoRemote.getContacts(_currentStorage);
      var storagesLocal = await _daoLocal.getStorages();
      var storageLocal = storagesLocal.firstWhere((sl) => sl.id == _currentStorage.id);
      var newContacts = <Contact>[];
      _currentStorage.contacts.forEach((cr) {
        try {
          var cl = storageLocal.contacts.firstWhere((cl) => cl.uuid == cr.uuid && cl.etag == cr.etag);
          newContacts.add(cl);
        } catch (_) {
          print('CONTACT INVALIDATE - ${cr.email}');
          newContacts.add(cr);
        }
      });
      _currentStorage.contacts = newContacts;
      _currentStorage.isLoaded = true;
    }
    emit(ContactState(_storages, _currentStorage, _currentStorage.contacts));
  }

  Future<void> loadContact(Contact contact) async {
    await _daoRemote.loadContact(_currentStorage, contact);
    emit(ContactState(_storages, _currentStorage, _currentStorage.contacts));
  }

  Future<void> refresh() async {
    emit(_waiting);
    await _load();
  }

  Future<void> reload() async {
    emit(_waiting);
    _localSavingTimer?.cancel();
    await _daoLocal.clearStorages();
    await _load();
  }
}
