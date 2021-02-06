import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/BidModel.dart';
import 'view/BidList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => BidModel(),
        child: MaterialApp(
          title: 'torgi.gov.ru',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BidList(),
        ),
      );
}
