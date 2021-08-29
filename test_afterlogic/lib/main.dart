import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/UserSessionModel.dart';
import 'model/ContactModel.dart';
import 'view/lib/common_widgets.dart';
import 'view/UserSessionLogin.dart';

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
        BlocProvider(create: (context) => ContactModel(context)),
      ],
      child: MaterialApp(
        title: 'Afterlogic Test',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: UserSessionLogin(),
      ),
    );
  }
}
