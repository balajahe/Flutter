import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        validator: (v) => (v.isEmpty) ? 'Обязательное поле' : null,
      ),
    );

class UserEdit extends StatefulWidget {
  @override
  createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController name;
  TextEditingController patronymic;
  TextEditingController surname;
  TextEditingController email;

  @override
  build(context) {
    return BlocConsumer<UserModel, UserState>(
      builder: (context, state) {
        name = TextEditingController(text: state.user.name);
        patronymic = TextEditingController(text: state.user.patronymic);
        surname = TextEditingController(text: state.user.surname);
        email = TextEditingController(text: state.user.email);
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ФИО", style: h2),
                          vspacer,
                          _textField('Введите имя', name),
                          vspacer,
                          _textField('Введите фамилию', surname),
                          vspacer,
                          _textField('Введите отчество', patronymic),
                          vspacer,
                          Text("Контактные данные", style: h2),
                          vspacer,
                          _textField('Введите емейл', email),
                          vspacer,
                          Text("Фотография", style: h2),
                          vspacer,
                          Image.asset('assets/blank_photo.png'),
                          TextButton(
                              child: Text('Добавить фотографию'),
                              onPressed: () {}),
                          ElevatedButton(
                            child: Text('Сохранить изменения'),
                            onPressed: _save,
                          ),
                        ],
                      ),
                    ),
                  ),
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => UserView()),
          );
        }
      },
    );
  }

  void _save() {
    context.read<UserModel>().save(
          User(
            name: name.text,
            patronymic: patronymic.text,
            surname: surname.text,
            email: email.text,
          ),
        );
  }
}
