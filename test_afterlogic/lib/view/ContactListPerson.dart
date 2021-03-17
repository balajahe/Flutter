import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/ContactListController.dart';
import 'afterlogic_widgets.dart';

class ContactListPerson extends StatelessWidget {
  @override
  build(context) {
    var controller = context.read<ContactListController>();
    var searchController = TextEditingController();
    return BlocBuilder<ContactListController, ContactListState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  var contact = state.data[i];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.email),
                    //onTap: () => Navigator.pop(context, defectType),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
