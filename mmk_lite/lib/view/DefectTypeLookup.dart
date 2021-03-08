import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectTypeModel.dart';

class DefectTypeLookup extends StatelessWidget {
  @override
  build(context) {
    var model = context.read<DefectTypeModel>();
    model.filter('');
    var searchController = TextEditingController();
    return BlocBuilder<DefectTypeModel, DefectTypeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Найти дефект...',
              hintStyle: TextStyle(color: Colors.white60),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            cursorWidth: 3,
            autofocus: true,
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
                    onTap: () {
                      Navigator.pop(context, defect);
                    },
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
