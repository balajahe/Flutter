import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/IssuesModel.dart';
import 'lib/common_widgets.dart';

class IssueView extends StatelessWidget {
  final Issue _issue;
  IssueView(this._issue);

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Претензия № ' + _issue.id)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(_issue.id),
            ],
          ),
        ),
      ),
    );
  }
}
