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
            children: _issue.defects
                .map((d) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text(d.certificate.name),
                        //Text(d.certificate.order),
                        Text(d.productType, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        //Text(d.position.batch),
                        Text('Дефект: ' + d.defectType.name),
                        Text('Вес брака, т: ' + d.weightDefect.toString()),
                        Hline1(),
                        Container(height: 5),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
