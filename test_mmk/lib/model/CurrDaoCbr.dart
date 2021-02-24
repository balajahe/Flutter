// Реализация DAO-объекта для API центробанка

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:enough_convert/enough_convert.dart';

import 'Curr.dart';
import 'CurrDaoAbstract.dart';
import '../settings.dart';

final url = Uri.https('cbr.ru', '/scripts/XML_daily.asp');

class CurrDaoCbr extends CurrDaoAbstract {
  Future<List<Curr>> getAll() async {
    final codec = const Windows1251Codec(allowInvalid: true);
    final res = XmlDocument.parse(codec.decode((await http.get(url)).bodyBytes))
        .findAllElements('Valute')
        .where((v) => currSelected.contains(v.getAttribute('ID')))
        .map((v) => Curr(
              id: v.getAttribute('ID'),
              numCode: int.parse(v.getElement('NumCode').text),
              charCode: v.getElement('CharCode').text,
              name: v.getElement('Name').text,
              nominal: int.parse(v.getElement('Nominal').text),
              value:
                  double.parse(v.getElement('Value').text.replaceAll(',', '.')),
            ))
        .toList();
    res.sort((a, b) => currSelected.indexOf(a.id) - currSelected.indexOf(b.id));
    return res;
  }
}
