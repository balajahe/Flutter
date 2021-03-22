import 'package:flutter/material.dart';

import '../entity/Arrangement.dart';
import '../model/ArrangementModel.dart';
import 'AbstractRefLookup.dart';

class ArrangementLookup extends AbstractRefLookup<Arrangement, ArrangementModel> {
  @override
  final hint = 'Найти урегулирование...';

  @override
  listTile(context, item) => ListTile(
        subtitle: Text(item.name),
        onTap: () => Navigator.pop(context, item),
      );
}
