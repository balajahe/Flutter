import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/SessionModel.dart';
import 'model/ContactModel.dart';
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
        BlocProvider(create: (context) => SessionModel()),
        BlocProvider(create: (context) => ContactModel(context.read<SessionModel>().dao)),
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
