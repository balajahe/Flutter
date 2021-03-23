import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/UserSessionModel.dart';
import 'model/IssueModel.dart';
import 'model/CertificateModel.dart';
import 'model/PositionModel.dart';
import 'model/DefectTypeModel.dart';
import 'model/ArrangementModel.dart';

import 'view/UserSessionLogin.dart';

void main() {
  ErrorWidget.builder = (e) => Scaffold(body: SingleChildScrollView(child: SelectableText(e.toString())));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserSessionModel()),
        BlocProvider(create: (context) => CertificateModel(context)),
        BlocProvider(create: (context) => DefectTypeModel(context)),
        BlocProvider(create: (context) => ArrangementModel(context)),
        BlocProvider(create: (context) => PositionModel(context)),
        BlocProvider(create: (context) => IssueModel()),
      ],
      child: MaterialApp(
        title: 'MMK Lite',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserSessionLogin(),
      ),
    );
  }
}
