import 'package:flutter/material.dart';

import '../entity/Arrangement.dart';
import '../model/ArrangementModel.dart';
import 'AbstractRefLookup.dart';

class ArrangementLookup extends AbstractRefLookup<Arrangement, ArrangementModel> {
  @override
  final hint = 'Найти урегулирование...';

  @override
  listTile(context, item) => Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListTile(
          subtitle: Text(item.name),
          onTap: () => Navigator.pop(context, item),
        ),
      );
}
