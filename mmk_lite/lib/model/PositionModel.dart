import 'package:flutter/material.dart';

import '../entity/Position.dart';
import '../dao/PositionDao.dart';
import '../model/AbstractRefModel.dart';

class PositionModel extends AbstractRefModel<Position> {
  PositionModel(BuildContext context)
      : super(
          context,
          daoCreate: (_) => PositionDao(_),
        );

  void filter(String s) {
    var filter = s.toLowerCase();
    emit(AbstractRefState(data
        .where((v) =>
            v.roll.toLowerCase().contains(filter) ||
            v.batch.toLowerCase().contains(filter) ||
            v.dimensions.toLowerCase().contains(filter) ||
            v.quantity.toString().contains(filter))
        .toList()));
  }
}
