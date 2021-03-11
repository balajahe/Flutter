import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/CertificateModel.dart';
import '../mmk_widgets.dart';

class CertificateLookup extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<CertificateModel>();
    model.clearFilter();
    var searchController = TextEditingController();
    return BlocBuilder<CertificateModel, CertificateState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: MmkFilterField(
            hint: 'Найти сертификат...',
            controller: searchController,
            onChanged: (v) => model.filter(v),
          ),
        ),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  var certificate = state.data[i];
                  return ListTile(
                    title: Text(certificate.code),
                    subtitle: Text(certificate.order),
                    trailing: Text(DateFormat('dd.MM.y').format(certificate.date)),
                    onTap: () => Navigator.pop(context, certificate.code),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
