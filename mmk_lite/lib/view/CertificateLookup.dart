import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/Certificate.dart';
import '../model/CertificateModel.dart';
import '../view/AbstractRefLookup.dart';

class CertificateLookup extends AbstractRefLookup<Certificate, CertificateModel> {
  @override
  final hint = 'Найти сертификат...';

  @override
  listTile(context, data) => ListTile(
        title: Text(data.name),
        subtitle: Text(data.order),
        trailing: Text(DateFormat('dd.MM.y').format(data.date)),
        visualDensity: VisualDensity.compact,
        onTap: () => Navigator.pop(context, data),
      );
}
