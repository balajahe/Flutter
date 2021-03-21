import 'package:flutter_bloc/flutter_bloc.dart';

import 'AbstractState.dart';
import '../entity/Certificate.dart';

class CertificateState extends AbstractState {
  List<Certificate> data;
  CertificateState(this.data);
}

class CertificateModel extends Cubit<CertificateState> {
  List<Certificate> _data = [];

  CertificateModel() : super(CertificateState([])..waiting = true) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _data = [
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
    emit(CertificateState(_data));
  }

  void filter(String s) {
    var _filter = s.toLowerCase();
    emit(CertificateState(
        _data.where((v) => v.id.toLowerCase().contains(_filter) || v.order.toLowerCase().contains(_filter)).toList()));
  }

  void clearFilter() {
    if (_data.length > 0) filter('');
  }
}
