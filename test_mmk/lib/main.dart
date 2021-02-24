import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/CurrModel.dart';
import 'view/CurrView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) => BlocProvider(
        create: (context) => CurrModel(),
        child: MaterialApp(
          title: 'test_unikoom_bloc',
          theme: ThemeData(primarySwatch: Colors.green),
          home: CurrView(),
        ),
      );
}
