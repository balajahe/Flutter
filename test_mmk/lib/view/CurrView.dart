import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/CurrModel.dart';

class CurrView extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Курсы валют'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => context.read<CurrModel>().init()),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<CurrModel, CurrState>(
          builder: (context, state) {
            if (state.status == CurrStatus.loaded) {
              return ListView(
                children: state.data.map((v) {
                  return Card(
                    child: ListTile(
                      leading: Text(v.charCode),
                      title: Text(v.name),
                      subtitle: Text('За ${v.nominal} единиц'),
                      trailing: Text(v.value.toString()),
                    ),
                  );
                }).toList(),
              );
            } else if (state.status == CurrStatus.error) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
