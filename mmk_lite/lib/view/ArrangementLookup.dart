import 'package:flutter/material.dart';

import '../entity/Arrangement.dart';
import '../model/ArrangementModel.dart';
import 'AbstractRefLookup.dart';

class ArrangementLookup extends AbstractRefLookup<Arrangement, ArrangementModel> {
  @override
  final hint = 'Найти урегулирование...';

  @override
  listTile(context, data) => Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListTile(
          subtitle: Text(data.name),
          onTap: () => Navigator.pop(context, data),
        ),
      );
}
