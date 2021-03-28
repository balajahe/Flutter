import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/IssuesModel.dart';
import 'lib/common_widgets.dart';
import 'IssueView.dart';

class IssueList extends StatelessWidget {
  @protected
  final String hint = 'Найти претензию...';

  @override
  build(context) {
    var model = context.read<IssuesModel>();
    model.clearFilter();
    var searchController = TextEditingController();
    return BlocBuilder<IssuesModel, IssuesState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: SearchTextField(
            hint: hint,
            controller: searchController,
            onChanged: (v) => model.filter(v),
          ),
        ),
        body: (!state.waiting)
            ? Padding(
                padding: EdgeInsets.only(top: 0),
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, i) {
                    var issue = state.data[i];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('№ ' + issue.id),
                          Text(
                            DateFormat('dd.MM.y').format(issue.date),
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(issue.weightDefects().toString() + ' тонн'),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(issue.defectTypes()),
                          Hline1(),
                        ],
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => IssueView(issue))),
                    );
                  },
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
