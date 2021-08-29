import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dao/Bid.dart';

class BidView extends StatelessWidget {
  final Bid _bid;
  final _dateFormat = DateFormat('dd.MM.yyyy HH:mm');
  final _labelStyle = TextStyle(color: Colors.grey, fontSize: 13);
  final _separator1 = Container(height: 10);
  final _separator2 = Container(
      height: 10,
      padding: EdgeInsets.all(4),
      child: Container(height: 2, color: Colors.grey));

  BidView(this._bid);

  @override
  build(context) {
    var details = <Widget>[
      Row(children: [
        Text('Номер: ', style: _labelStyle),
        Text(_bid.bidNumber),
      ]),
      _separator1,
      Text('Тип: ', style: _labelStyle),
      Text(_bid.bidKindName),
      _separator1,
      Text('Организация: ', style: _labelStyle),
      Text(_bid.organizationName),
      _separator1,
      Row(children: [
        Text('Размещено: ', style: _labelStyle),
        Text(_dateFormat.format(_bid.publishDate)),
      ]),
      Row(children: [
        Text('Изменено: ', style: _labelStyle),
        Text(_dateFormat.format(_bid.lastChanged)),
      ]),
      _bid.isArchived ? Text('АРХИВ') : Container(),
      _separator1,
    ];

    if (_bid.xml != null) {
      _bid.lots.forEach((lot) {
        details.add(Text(lot));
        details.add(_separator2);
      });
      details.add(Text(_bid.xml, style: TextStyle(fontSize: 12)));
    } else {
      details.add(Text('Детализация загружается, попробуйте чуть позже...',
          style: TextStyle(fontSize: 12)));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(150, 100, 100, 100),
      appBar: AppBar(
        title: Text(_bid.bidNumber),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
