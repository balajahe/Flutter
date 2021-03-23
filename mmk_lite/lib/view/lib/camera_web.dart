import 'dart:typed_data';
import 'dart:html' as dom;

Future<Uint8List> pickImage() async {
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
  } else {
    return null;
  }
}
