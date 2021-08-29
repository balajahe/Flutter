import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ItemModel.dart';
import '../view/ItemView.dart';

class ItemsList extends StatelessWidget {
  @override
  build(context) {
    return BlocBuilder<ItemModel, ItemState>(
      builder: (context, state) {
        var model = context.read<ItemModel>();
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: TextEditingController(text: state.searchString),
              decoration: InputDecoration(
                hintText: "Найти...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white60),
              ),
              cursorColor: Colors.white,
              onSubmitted: (text) => model.getWhere(text),
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
                              ? Text(el.text
                                      .substring(0, min(100, el.text.length)) +
                                  '...')
                              : null,
                          trailing: el == state.selected
                              ? IconButton(
                                  tooltip: 'Подробнее...',
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, _, __) =>
                                          ItemView(el),
                                    ),
                                  ),
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
