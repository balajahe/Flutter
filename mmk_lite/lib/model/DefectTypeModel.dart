import 'package:flutter/material.dart';

import '../entity/DefectType.dart';
import '../dao/DefectTypeDao.dart';
import '../model/AbstractRefModel.dart';

class DefectTypeModel extends AbstractRefModel<DefectType> {
  DefectTypeModel(BuildContext context)
      : super(
          context,
          daoCreate: (_) => DefectTypeDao(_),
        );
}
