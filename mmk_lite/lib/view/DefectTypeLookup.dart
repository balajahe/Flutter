import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectTypeModel.dart';
import '../mmk_widgets.dart';

class DefectTypeLookup extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<DefectTypeModel>();
    model.clearFilter();
    var searchController = TextEditingController();
    return BlocBuilder<DefectTypeModel, DefectTypeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: MmkFilterLield(
            hint: 'Найти дефект...',
            controller: searchController,
            onChanged: (v) => model.filter(v),
          ),
        ),
        body: (!state.waiting)
            ? ListView.builder(
                itemCount: state.all.length,
                itemBuilder: (context, i) {
                  var defect = state.all[i];
                  return ListTile(
                    title: Text(defect),
                    onTap: () => Navigator.pop(context, defect),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
