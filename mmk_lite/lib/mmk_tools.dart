import 'dart:io';
import 'dart:html' as dom;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

bool validatePhone(String v) {
  return RegExp(r'(^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$)').hasMatch(v);
}

bool validateEmail(String v) {
  return RegExp(
          r"(^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$)")
      .hasMatch(v);
}

Future<Uint8List> pickImage() async {
  if (kIsWeb) {
    var uploadInput = dom.FileUploadInputElement();
    uploadInput.click();
    await uploadInput.onChange.first;

    final files = uploadInput.files;
    if (files.length > 0) {
      final file = files[0];
      var reader = dom.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;
      return reader.result;
    }
  } else {
    var pfile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pfile != null) {
      var file = File(pfile.path);
      return await file.readAsBytes();
    }
  }
  return null;
}
