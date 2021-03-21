import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Position.dart';

class PositionState extends AbstractState {
  List<Position> data;
  PositionState(this.data);
}

class PositionModel extends Cubit<PositionState> {
  List<Position> _data = [];
  String _filter = '';

  PositionModel() : super(PositionState([])..waiting = true) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _data = [
      Position()
        ..num = 1
        ..roll = 'рулон1'
        ..batch = '001'
        ..dimensions = '12x144'
        ..quantity = 123.11,
      Position()
        ..num = 2
        ..roll = 'рулон2'
        ..batch = '005'
        ..dimensions = '111x11'
        ..quantity = 34543543.11,
      Position()
        ..num = 3
        ..roll = 'рулон3'
        ..batch = '011'
        ..dimensions = '8x15'
        ..quantity = 0.123,
    ];
    emit(PositionState(_data));
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(PositionState(_data
        .where((v) =>
            v.roll.toLowerCase().contains(_filter) ||
            v.batch.toLowerCase().contains(_filter) ||
            v.dimensions.toLowerCase().contains(_filter) ||
            v.quantity.toString().contains(_filter))
        .toList()));
  }

  void clearFilter() {
    if (_data.length > 0) filter('');
  }
}
