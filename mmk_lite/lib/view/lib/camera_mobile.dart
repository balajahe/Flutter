import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage(BuildContext context) async {
  ImageSource imageSource;
  await ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
          content: Row(
        children: [
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              imageSource = ImageSource.camera;
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.image_search),
            onPressed: () {
              imageSource = ImageSource.gallery;
              Navigator.pop(context);
            },
          ),
        ],
      )))
      .closed;
  var pfile = await ImagePicker().getImage(source: imageSource);
  if (pfile != null) {
    return await File(pfile.path).readAsBytes();
  } else {
    return null;
  }
}
