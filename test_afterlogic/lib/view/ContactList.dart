import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Contact.dart';
import '../model/ContactModel.dart';
import 'ContactView.dart';
import 'SessionLogin.dart';

class ContactList extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<ContactModel>();
    return BlocBuilder<ContactModel, ContactState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Contacts'),
            Text('personal', style: TextStyle(fontSize: 11)),
          ]),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => model.refresh(),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => SessionLogin()),
                (_) => false,
              ),
            ),
          ],
        ),
        drawer: Drawer(),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  var contact = state.data[i];
                  if (contact.email.length > 0) {
                    return ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.email),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactView(contact))),
                    );
                  } else {
                    model.read(contact);
                    return ListTile(
                      title: Text(contact.uuid),
                      subtitle: Text(contact.etag),
                      onTap: () {},
                    );
                  }
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }

  void _view(Contact contact) {}
}
