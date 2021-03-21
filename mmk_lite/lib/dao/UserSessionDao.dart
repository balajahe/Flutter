import '../entity/UserSession.dart';

class UserSessionDao {
  Future<void> login(UserSession userSession) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
