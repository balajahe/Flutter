// Вью-модель на основе кубита

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Curr.dart';
import '../settings.dart';

enum CurrStatus { loading, loaded, error }

class CurrState {
  CurrStatus status;
  DateTime date;
  List<Curr> data;
  String error;

  CurrState({this.status, this.date, this.data, this.error});
  CurrState.init() {
    status = CurrStatus.loading;
  }
}

class CurrModel extends Cubit<CurrState> {
  CurrModel() : super(CurrState.init()) {
    refresh(null);
  }

  void refresh(DateTime date) async {
    emit(CurrState(
      status: CurrStatus.loading,
      date: date,
    ));
    try {
      emit(CurrState(
        status: CurrStatus.loaded,
        date: date,
        data: await currDaoInstance.getAll(date),
      ));
    } catch (e) {
      emit(CurrState(
        status: CurrStatus.error,
        error: e.toString(),
      ));
    }
  }
}
