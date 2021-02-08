import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings.dart';
import '../model/UserModel.dart';
import 'UserEdit.dart';

class UserView extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<UserModel, UserState>(builder: (context, state) {
      return Scaffold(
        appBar: appBar,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text('Мой профиль', style: h1)),
                Card(
                  margin: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/blank_photo.png', scale: 1),
                        vspacer,
                        Text(
                          '${state.user.name} ${state.user.patronymic} ${state.user.surname}',
                          style: h2,
                        ),
                        Text(state.user.email, style: h2),
                        vspacer,
                        ElevatedButton(
                          child: Text('Редактировать профиль'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => UserEdit()),
                            );
                          },
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
    });
  }
}
