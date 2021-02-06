import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ItemModel.dart';
import '../view/ItemView.dart';

class ItemsList extends StatefulWidget {
  @override
  createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final _searchString = TextEditingController();

  @override
  build(context) {
    return BlocBuilder<ItemModel, ItemState>(
      builder: (context, state) {
        var model = context.read<ItemModel>();
        _searchString.text = state.searchString;
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _searchString,
              decoration: InputDecoration(
                hintText: "Найти...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white60),
              ),
              cursorColor: Colors.white,
              onSubmitted: (_) => model.getWhere(_searchString.text),
            ),
            actions: [
              IconButton(
                tooltip: 'Отменить поиск',
                icon: Icon(Icons.clear),
                onPressed: () => model.getWhere(''),
              ),
              IconButton(
                tooltip: 'Обновить данные',
                icon: Icon(Icons.refresh),
                onPressed: () => model.getAll(),
              ),
            ],
          ),
          body: !state.isLoading
              ? ListView(
                  children: state.items
                      .map(
                        (el) => ListTile(
                          title: Text(el.title),
                          subtitle: el == state.selected
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(el.text),
                                    TextButton(
                                      child: Text('подробнее...'),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero)),
                                      onPressed: () => Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          fullscreenDialog: true,
                                          opaque: false,
                                          pageBuilder: (context, _, __) =>
                                              ItemView(el),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                          onTap: () => model.select(el),
                        ),
                      )
                      .toList(),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
