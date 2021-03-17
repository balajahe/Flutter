import 'package:flutter/material.dart';

import '../entity/Contact.dart';

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(contact.name),
              Text(contact.email),
            ],
          ),
        ));
  }
}
