import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/UserModel.dart';
import 'model/ContactModel.dart';
import 'view/UserLogin.dart';

void main() {
  ErrorWidget.builder = (e) => Scaffold(body: SingleChildScrollView(child: SelectableText(e.toString())));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserModel()),
        BlocProvider(create: (context) => ContactModel(context.read<UserModel>().daoSession)),
      ],
      child: MaterialApp(
        title: 'Afterlogic Test',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SessionLogin(),
      ),
    );
  }
}
