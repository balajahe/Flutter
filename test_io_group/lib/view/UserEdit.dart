import 'dart:io';
import 'dart:html' as dom;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../settings.dart';
import '../dao/User.dart';
import '../model/UserModel.dart';
import 'UserView.dart';

class UserEdit extends StatelessWidget {
  @override
  build(context) {
    return BlocConsumer<UserModel, UserState>(
      builder: (context, state) {
        // _name.text = state.user.name;
        // _patronymic.text = state.user.patronymic;
        // _surname.text = state.user.surname;
        // _email.text = state.user.email;
        var model = context.read<UserModel>();
        return Scaffold(
          appBar: appBar,
          body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text('Редактирование профиля', style: h1)),
                  Card(
                    margin: EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ФИО", style: h2),
                          vspacer,
                          _textField(
                              'Введите имя', state.user.name, model.editName),
                          vspacer,
                          _textField('Введите фамилию', state.user.surname,
                              model.editSurname),
                          vspacer,
                          _textField('Введите отчество', state.user.patronymic,
                              model.editPatronymic),
                          vspacer,
                          Text("Контактные данные", style: h2),
                          vspacer,
                          _textField('Введите емейл', state.user.email,
                              model.editEmail),
                          vspacer,
                          Text("Фотография", style: h2),
                          vspacer,
                          Container(
                            width: 150,
                            height: 150,
                            child: (state.user.photoOrigin != null)
                                ? Image.memory(state.user.photoOrigin,
                                    fit: BoxFit.cover)
                                : Image.asset('assets/blank_photo.png',
                                    fit: BoxFit.cover),
                          ),
                          TextButton(
                              child: Text('Добавить фотографию'),
                              onPressed: () => _addPhoto(model, state.user)),
                          ElevatedButton(
                              child: Text('Сохранить изменения'),
                              onPressed: () => model.save()),
                        ],
                      ),
                    ),
                  ),
                  vspacer,
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == UserStatus.notSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state.status == UserStatus.saved) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => UserView()),
            (_) => false,
          );
        }
      },
    );
  }

  void _addPhoto(UserModel model, User user) async {
    if (kIsWeb) {
      var uploadInput = dom.FileUploadInputElement();
      uploadInput.click();
      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files.length == 1) {
          final file = files[0];
          var reader = dom.FileReader();
          reader.readAsArrayBuffer(file);
          reader.onLoadEnd.listen((e) {
            user.photoOrigin = reader.result;
            model.editPhotoOrigin(user.photoOrigin);
          });
          reader.onError.listen((e) {
            print(e);
          });
        }
      });
    } else {
      var result = await FilePicker.platform.pickFiles();
      if (result != null) {
        var file = File(result.files.first.path);
        user.photoOrigin = await file.readAsBytes();
        model.editPhotoOrigin(user.photoOrigin);
      }
    }
  }

  Widget _textField(String label, String value, Function(String) onChanged) =>
      Container(
        height: 50,
        child: TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      );
}
