import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ContactModel.dart';
import 'lib/LogoutButton.dart';
import 'lib/StorageDrawer.dart';
import 'ContactView.dart';

class ContactList extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<ContactModel>();
    return BlocBuilder<ContactModel, ContactState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Contacts'),
            Text(state.data.currentStorage.id, style: TextStyle(fontSize: 11)),
          ]),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => model.refresh(),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              tooltip: 'Clear Cache',
              onPressed: () => model.reload(),
            ),
            LogoutButton(),
          ],
        ),
        drawer: StorageDrawer(),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.selectedContacts.length,
                itemBuilder: (context, i) {
                  var contact = state.data.selectedContacts[i];
                  if (contact.email.length > 0) {
                    return ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.email),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactView(contact))),
                    );
                  } else {
                    model.loadContact(contact);
                    return ListTile(
                      title: Text('...'),
                      subtitle: Text(''),
                      onTap: () {},
                    );
                  }
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
