import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ContactModel.dart';
import 'lib/LogoutButton.dart';
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
            Text('personal', style: TextStyle(fontSize: 11)),
          ]),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => model.refresh(),
            ),
            LogoutButton(),
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
