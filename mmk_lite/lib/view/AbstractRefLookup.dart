import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/AbstractRef.dart';
import '../model/AbstractRefModel.dart';
import 'lib/common_widgets.dart';

class AbstractRefLookup<TData extends AbstractRef, TModel extends AbstractRefModel> extends StatelessWidget {
  @protected
  final String hint = 'Найти чего нибудь...';

  Widget listTile(BuildContext context, TData data) => ListTile(
        title: Text(data.name),
        visualDensity: VisualDensity.compact,
        onTap: () => Navigator.pop(context, data),
      );

  @override
  build(context) {
    var model = context.read<TModel>();
    model.clearFilter();
    var searchController = TextEditingController();
    return BlocBuilder<TModel, RefState>(builder: (context, state) {
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
                    var item = state.data[i];
                    return listTile(context, item);
                  },
                ),
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
