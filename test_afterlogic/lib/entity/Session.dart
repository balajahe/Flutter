class Session {
  String host = 'https://webmail.afterlogic.com';
  String email = 'job_applicant@afterlogic.com';
  String password = '';
  String authToken = '';

  Session clone() => Session()
    ..host = host
    ..email = email
    ..authToken = authToken;
}
