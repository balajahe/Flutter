import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/UserSessionModel.dart';
import 'model/CertificateModel.dart';
import 'model/PositionModel.dart';
import 'model/DefectTypeModel.dart';
import 'model/ArrangementModel.dart';
import 'model/IssuesModel.dart';
import 'model/IssueModel.dart';

import 'view/UserSessionLogin.dart';
import 'view/lib/common_widgets.dart';

void main() {
  ErrorWidget.builder = (e) => ErrorScreen(e);
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
        BlocProvider(create: (context) => IssuesModel(context)),
        BlocProvider(create: (context) => IssueModel(context)),
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
