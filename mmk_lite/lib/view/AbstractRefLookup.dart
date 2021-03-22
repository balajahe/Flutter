import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/AbstractRef.dart';
import '../model/AbstractRefModel.dart';
import '../tools/mmk_widgets.dart';

class AbstractRefLookup<TData extends AbstractRef, TModel extends AbstractRefModel> extends StatelessWidget {
  final String hint = 'Найти чего нибудь...';

  Widget listTile(BuildContext context, TData item) => ListTile(
        title: Text(item.name),
        onTap: () => Navigator.pop(context, item),
      );

  @override
  build(context) {
    var model = context.read<TModel>();
    model.clearFilter();
    var searchController = TextEditingController();
    return BlocBuilder<TModel, AbstractRefState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: MmkFilterField(
            hint: hint,
            controller: searchController,
            onChanged: (v) => model.filter(v),
          ),
        ),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  var item = state.data[i];
                  return listTile(context, item);
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
