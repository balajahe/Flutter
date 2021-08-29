import '../entity/Certificate.dart';
import 'AbstractRefDao.dart';
import 'UserSessionDao.dart';

class CertificateDao extends AbstractRefDao {
  CertificateDao(UserSessionDao userSessionDao) : super(userSessionDao);

  Future<List<Certificate>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Certificate()
        ..id = '1'
        ..name = 'Сертификат1'
        ..order = 'Заказ1'
        ..date = DateTime.now(),
      Certificate()
        ..id = '2'
        ..name = 'Сертификат2'
        ..order = 'Заказ2'
        ..date = DateTime.now(),
      Certificate()
        ..id = '3'
        ..name = 'Сертификат3'
        ..order = 'Заказ3'
        ..date = DateTime.now(),
    ];
  }
}
