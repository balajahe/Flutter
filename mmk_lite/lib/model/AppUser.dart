enum AuthType { registered, unregistered }

enum AuthStatus { none, ok, error }

class AppUser {
  AuthType authType;
  AuthStatus authStatus;
  String authStatusError;
  String name;
  String login;
  String password;
  String email;
  String phone;

  AppUser({
    this.authType = AuthType.registered,
    this.authStatus = AuthStatus.none,
    this.authStatusError,
    this.name,
    this.login = '',
    this.password = '',
    this.email = '',
    this.phone = '',
  });
}
