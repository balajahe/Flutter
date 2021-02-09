import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_io_group/view/UserNotExist.dart';

import 'model/UserModel.dart';
import 'view/UserNotExist.dart';
import 'view/UserView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return BlocProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'test_io_group',
        theme: ThemeData(
          canvasColor: Colors.blue[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        ),
        home: BlocBuilder<UserModel, UserState>(builder: (context, state) {
          if (state.status == UserStatus.loading)
            return Center(child: CircularProgressIndicator());
          else if (state.status == UserStatus.notExist)
            return UserNotExist();
          else
            return UserView();
        }),
      ),
    );
  }
}
