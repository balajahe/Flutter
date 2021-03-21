import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Certificate.dart';

class CertificateState extends AbstractState {
  List<Certificate> data;
  CertificateState(this.data);
}

class CertificateModel extends Cubit<CertificateState> {
  List<Certificate> _all = [];
  String _filter = '';

  CertificateModel() : super(CertificateState([])..waiting = true) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _all = [
      Certificate()
        ..id = 'Сертификат1'
        ..order = 'Заказ1'
        ..date = DateTime.now(),
      Certificate()
        ..id = 'Сертификат2'
        ..order = 'Заказ2'
        ..date = DateTime.now(),
      Certificate()
        ..id = 'Сертификат3'
        ..order = 'Заказ3'
        ..date = DateTime.now(),
    ];
    emit(CertificateState(_all));
  }

  void filter(String s) {
    _filter = s.toLowerCase();
    emit(CertificateState(
        _all.where((v) => v.id.toLowerCase().contains(_filter) || v.order.toLowerCase().contains(_filter)).toList())
      ..filter = _filter);
  }

  void clearFilter() {
    if (_filter.length > 0) filter('');
  }
}
