import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/CurrModel.dart';

class CurrView extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<CurrModel, CurrState>(builder: (context, state) {
      final dformat = DateFormat('dd.MM.y');
      return Scaffold(
        appBar: AppBar(
          title: TextButton(
            child: Text(
              (state.date != null)
                  ? dformat.format(state.date)
                  : 'Введите дату...',
              style: TextStyle(color: Colors.white70),
            ),
            onPressed: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: (state.date != null) ? state.date : DateTime.now(),
                firstDate: DateTime.parse('1900-01-01'),
                lastDate: DateTime.now(),
              );
              context.read<CurrModel>().refresh(d);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => context.read<CurrModel>().refresh(null),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: (state.status == CurrStatus.loaded)
              ? ListView(
                  children: state.data.map((v) {
                    return Card(
                      child: ListTile(
                        leading: Text(
                          v.charCode,
                          style: TextStyle(fontSize: 18),
                        ),
                        title: Text(v.name),
                        subtitle: Text('За ${v.nominal} единиц'),
                        trailing: Text(v.value.toString()),
                      ),
                    );
                  }).toList(),
                )
              : (state.status == CurrStatus.error)
                  ? Center(child: Text(state.error))
                  : Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}
