import 'package:flutter/material.dart';

import '../entity/Position.dart';
import '../model/PositionModel.dart';
import '../view/AbstractRefLookup.dart';
import '../tools/common_widgets.dart';

class PositionLookup extends AbstractRefLookup<Position, PositionModel> {
  @override
  final hint = 'Найти позицию...';

  @override
  listTile(context, item) => ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('№', style: gridHeaderStyle), flex: 1),
                Expanded(child: Text('Рулон', style: gridHeaderStyle), flex: 3),
                Expanded(child: Text('Партия', style: gridHeaderStyle), flex: 2),
                Expanded(child: Text('Толщ.Шир.', style: gridHeaderStyle), flex: 3),
                Expanded(child: Text('Кол-во', style: gridHeaderStyle), flex: 4),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(item.num.toString()), flex: 1),
                Expanded(child: Text(item.roll), flex: 3),
                Expanded(child: Text(item.batch.toString()), flex: 2),
                Expanded(child: Text(item.dimensions), flex: 3),
                Expanded(child: Text(item.quantity.toString()), flex: 4),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.pop(context, item),
      );
}
