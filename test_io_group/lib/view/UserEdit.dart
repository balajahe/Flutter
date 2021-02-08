import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../settings.dart';
import '../dao/User.dart';
import '../model/UserModel.dart';
import 'UserView.dart';

Widget _textField(String label, TextEditingController controller) => Container(
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );

class UserEdit extends StatefulWidget {
  @override
  createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _patronymic = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  Uint8List _photoOrigin;

  @override
  initState() {
    super.initState();
    var user = context.read<UserModel>().state.user;
    _photoOrigin = user.photoOrigin;
  }

  @override
  build(context) {
    return BlocConsumer<UserModel, UserState>(
      builder: (context, state) {
        _name.text = state.user.name;
        _patronymic.text = state.user.patronymic;
        _surname.text = state.user.surname;
        _email.text = state.user.email;
        return Scaffold(
          appBar: appBar,
          body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text('Редактирование профиля', style: h1)),
                  Form(
                    key: _form,
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ФИО", style: h2),
                            vspacer,
                            _textField('Введите имя', _name),
                            vspacer,
                            _textField('Введите фамилию', _surname),
                            vspacer,
                            _textField('Введите отчество', _patronymic),
                            vspacer,
                            Text("Контактные данные", style: h2),
                            vspacer,
                            _textField('Введите емейл', _email),
                            vspacer,
                            Text("Фотография", style: h2),
                            vspacer,
                            Container(
                              width: 150,
                              height: 150,
                              child: (_photoOrigin != null)
                                  ? Image.memory(
                                      _photoOrigin,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/blank_photo.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            TextButton(
                                child: Text('Добавить фотографию'),
                                onPressed: _addPhoto),
                            ElevatedButton(
                              child: Text('Сохранить изменения'),
                              onPressed: _save,
                            ),
                          ],
                        ),
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

  void _addPhoto() async {
    var result = await FilePicker.platform.pickFiles();
    if (result != null) {
      var file = File(result.files.first.path);
      _photoOrigin = await file.readAsBytes();
      setState(() {});
    }
  }

  void _save() {
    if (_form.currentState.validate()) {
      context.read<UserModel>().save(
            User(
              name: _name.text,
              patronymic: _patronymic.text,
              surname: _surname.text,
              email: _email.text,
              photoOrigin: _photoOrigin,
            ),
          );
    }
  }
}
