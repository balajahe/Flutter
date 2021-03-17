import '../entity/User.dart';

class UserDao {
  Future<User> login(User user) async {
    Future.delayed(Duration(seconds: 2));
    return user;
  }
}
