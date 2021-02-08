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
        theme: ThemeData(primarySwatch: Colors.yellow),
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
