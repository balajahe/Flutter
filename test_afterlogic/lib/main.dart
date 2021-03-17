import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/SessionController.dart';
import 'controller/ContactListController.dart';

import 'view/SessionLogin.dart';

void main() {
  ErrorWidget.builder = (e) => Scaffold(body: SingleChildScrollView(child: SelectableText(e.toString())));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SessionController()),
        BlocProvider(
          create: (context) => ContactListController(
            sessionController: context.read<SessionController>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Afterlogic Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SessionLogin(),
      ),
    );
  }
}
