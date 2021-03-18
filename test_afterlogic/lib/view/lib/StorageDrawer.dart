import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/ContactModel.dart';

class StorageDrawer extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<ContactModel, ContactState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: state.data.storages
                .map(
                  (v) => ListTile(
                    title: Text(v.id.toUpperCase()),
                    onTap: () {
                      context.read<ContactModel>().setStorage(v);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
