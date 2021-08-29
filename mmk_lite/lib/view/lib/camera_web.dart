import 'package:flutter/material.dart';
import 'dart:html' as dom;

import '../../entity/Defect.dart';

Future<DefectFile> pickFile(BuildContext context) async {
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
    return DefectFile(file.relativePath + file.name, reader.result);
  } else {
    return null;
  }
}
