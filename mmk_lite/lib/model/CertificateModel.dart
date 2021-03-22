import 'package:flutter/material.dart';

import '../entity/Certificate.dart';
import '../dao/CertificateDao.dart';
import '../model/AbstractRefModel.dart';

class CertificateModel extends AbstractRefModel<Certificate> {
  CertificateModel(BuildContext context)
      : super(
          context,
          daoCreate: (_) => CertificateDao(_),
        );

  @override
  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(AbstractRefState(data
        .where((v) =>
            v.id.toLowerCase().contains(_filter) ||
            v.name.toLowerCase().contains(_filter) ||
            v.order.toLowerCase().contains(_filter))
        .toList()));
  }
}
