import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/CertificateModel.dart';

class CertificateLookup extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<CertificateModel, List<String>>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Сертификаты'),
        ),
        body: (state.length > 0)
            ? ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(state[i]),
                    onTap: () => Navigator.pop(context, state[i]),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
