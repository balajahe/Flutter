import 'package:flutter_bloc/flutter_bloc.dart';

class CertificateModel extends Cubit<List<String>> {
  List<String> _all = [];
  CertificateModel() : super([]) {
    _load();
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    _all = ['Сертификат1', 'Сертификат2', 'Сертификат3'];
    emit(List.from(_all));
  }
}
