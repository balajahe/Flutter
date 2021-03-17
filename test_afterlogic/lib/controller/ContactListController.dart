import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Contact.dart';
import '../controller/SessionController.dart';
import '../dao/ContactListDao.dart';

class ContactListState extends AbstractState<List<Contact>> {
  ContactListState(List<Contact> data) : super(data);
}

class ContactListController extends Cubit<ContactListState> {
  List<Contact> _data = [];
  SessionController sessionController;

  ContactListController({this.sessionController}) : super(ContactListState([])..waiting = true) {
    _load();
  }

  void _load() async {
    _data = await ContactListDao(session: sessionController.session).getAll();
    emit(ContactListState(_data));
  }

  void refresh() {
    emit(ContactListState(_data)..waiting = true);
    _load();
  }
}
