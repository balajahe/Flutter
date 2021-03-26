import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../entity/Defect.dart';

Future<DefectFile> pickFile(BuildContext context) async {
  ImageSource imageSource;
  await ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
          content: Row(
        children: [
          Expanded(
            child: Container(
              height: 70,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera, color: Colors.white),
                    onPressed: () {
                      imageSource = ImageSource.camera;
                      Navigator.pop(context);
                    },
                  ),
                  Text('Камера'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_search, color: Colors.white),
                    onPressed: () {
                      imageSource = ImageSource.gallery;
                      Navigator.pop(context);
                    },
                  ),
                  Text('Галлерея'),
                ],
              ),
            ),
          ),
        ],
      )))
      .closed;
  if (imageSource != null) {
    var file = await ImagePicker().getImage(source: imageSource);
    if (file != null) {
      return DefectFile(file.path, await File(file.path).readAsBytes());
    }
  }
  return null;
}
