import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage() async {
  var pfile = await ImagePicker().getImage(source: ImageSource.gallery);
  if (pfile != null) {
    var file = File(pfile.path);
    return await file.readAsBytes();
  } else {
    return null;
  }
}
