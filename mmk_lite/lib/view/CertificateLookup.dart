import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/Certificate.dart';
import '../model/CertificateModel.dart';

class CertificateLookup extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<CertificateModel, List<Certificate>>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Сертификаты'),
        ),
        body: (state.length > 0)
            ? ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(state[i].code),
                    subtitle: Text(state[i].order),
                    trailing: Text(DateFormat('dd.MM.y').format(state[i].date)),
                    onTap: () => Navigator.pop(context, state[i].code),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
