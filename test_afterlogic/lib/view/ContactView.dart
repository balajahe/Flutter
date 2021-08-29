import 'package:flutter/material.dart';

import '../entity/Contact.dart';
import 'lib/common_widgets.dart';
import 'lib/LogoutButton.dart';

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          actions: [LogoutButton()],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _Item(label: 'Display Name', text: contact.name),
              _Item(label: 'Email', text: contact.email),
              _Item(label: 'Phone', text: contact.phone),
              _Item(label: 'Address', text: contact.address),
              _Item(label: 'Skype', text: contact.skype),
              _Item(label: 'Facebook', text: contact.facebook),
            ],
          ),
        ));
  }
}

class _Item extends StatelessWidget {
  final String label;
  final String text;

  _Item({this.label, this.text});

  @override
  build(context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(text),
              ),
            ],
          ),
          Hline2(),
        ],
      ),
    );
  }
}
