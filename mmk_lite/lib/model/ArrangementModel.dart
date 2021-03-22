import 'package:flutter/material.dart';

import '../entity/Arrangement.dart';
import '../dao/ArrangementDao.dart';
import '../model/AbstractRefModel.dart';

class ArrangementModel extends AbstractRefModel<Arrangement> {
  ArrangementModel(BuildContext context)
      : super(
          context,
          daoCreate: (_) => ArrangementDao(_),
        );
}
