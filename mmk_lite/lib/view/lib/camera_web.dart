import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:html' as dom;

Future<Uint8List> pickImage(BuildContext context) async {
  var uploadInput = dom.FileUploadInputElement();
  //uploadInput.accept = 'image/*';
  uploadInput.click();
  await uploadInput.onChange.first;

  final files = uploadInput.files;
  if (files.length > 0) {
    final file = files[0];
    var reader = dom.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;
    return reader.result;
  } else {
    return null;
  }
}
