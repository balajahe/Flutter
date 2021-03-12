export 'camera_mobile.dart' if (dart.library.html) 'camera_web.dart' show pickImage;

bool validatePhone(String v) {
  return RegExp(r'(^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$)').hasMatch(v);
}

bool validateEmail(String v) {
  return RegExp(
          r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
      .hasMatch(v);
}
