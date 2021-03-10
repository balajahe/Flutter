import 'package:flutter_bloc/flutter_bloc.dart';

import 'Certificate.dart';

class CertificateModel extends Cubit<List<Certificate>> {
  List<Certificate> _all = [];

  CertificateModel() : super([]) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _all = [
      Certificate()
        ..code = 'Сертификат1'
        ..order = 'Заказ1'
        ..date = DateTime.now(),
      Certificate()
        ..code = 'Сертификат2'
        ..order = 'Заказ2'
        ..date = DateTime.now(),
      Certificate()
        ..code = 'Сертификат3'
        ..order = 'Заказ3'
        ..date = DateTime.now(),
    ];
    emit(List.from(_all));
  }
}
