import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/Certificate.dart';
import '../model/CertificateModel.dart';
import '../view/AbstractRefLookup.dart';

class CertificateLookup extends AbstractRefLookup<Certificate, CertificateModel> {
  @override
  final hint = 'Найти сертификат...';

  @override
  listTile(context, item) => ListTile(
        title: Text(item.name),
        subtitle: Text(item.order),
        trailing: Text(DateFormat('dd.MM.y').format(item.date)),
        visualDensity: VisualDensity.compact,
        onTap: () => Navigator.pop(context, item),
      );
}
