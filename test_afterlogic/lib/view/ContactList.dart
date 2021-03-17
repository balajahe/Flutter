import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/ContactListController.dart';
import 'SessionLogin.dart';

class ContactList extends StatelessWidget {
  @override
  build(context) {
    var controller = context.read<ContactListController>();
    return BlocBuilder<ContactListController, ContactListState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => controller.refresh(),
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
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  var contact = state.data[i];
                  return ListTile(
                    title: Text(contact.uuid),
                    subtitle: Text(contact.etag),
                    onTap: () {},
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
