import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/UserController.dart';
import 'controller/ContactListController.dart';

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
        BlocProvider(create: (context) => UserController()),
        BlocProvider(create: (context) => ContactListController()),
      ],
      child: MaterialApp(
        title: 'Afterlogic Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserLogin(),
      ),
    );
  }
}
