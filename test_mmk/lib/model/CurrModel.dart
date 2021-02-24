// Вью-модель на основе кубита

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Curr.dart';
import '../settings.dart';

enum CurrStatus { loading, loaded, error }

class CurrState {
  CurrStatus status;
  String error;
  List<Curr> data;

  CurrState({this.status, this.error, this.data});
  CurrState.init() {
    status = CurrStatus.loading;
  }
}

class CurrModel extends Cubit<CurrState> {
  CurrModel() : super(CurrState.init()) {
    init();
  }

  void init() async {
    emit(CurrState.init());
    try {
      emit(CurrState(
        status: CurrStatus.loaded,
        data: await currDaoInstance.getAll(),
      ));
    } catch (e) {
      emit(CurrState(
        status: CurrStatus.error,
        error: e.toString(),
      ));
    }
  }
}
