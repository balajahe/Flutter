import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

import '../dao/Bid.dart';

const _apiUrl =
    'https://torgi.gov.ru/opendata/7710349494-torgi/data-{publishDateFrom}-{publishDateTo}-structure-20130401T0000.xml';

const _apiStep = Duration(hours: 1); //размер порции данных

abstract class _BidEvent {}

//загрузить следующую порцию
class Next extends _BidEvent {}

//обновить
class Refresh extends _BidEvent {}

//искать текст
class Search extends _BidEvent {
  final String text;
  Search(this.text);
}

class BidModel extends Bloc<_BidEvent, List<Bid>> {
  List<Bid> _all;
  DateTime _toDate; //граница загруженных данных списка
  String _searchText;
  int _loadedDetails; //граница загруженных деталей

  BidModel() : super([]) {
    _clear();
  }

  void _clear() {
    _all = [];
    _searchText = null;
    _toDate = DateTime.now(); //начинаем с последних данных
    _loadedDetails = 0;
  }

  void _loadNext() async {
    var fromDate = _toDate.subtract(_apiStep);
    var fmt = DateFormat('yyyyMMddTHHmm');
    var url = _apiUrl
        .replaceAll('{publishDateFrom}', fmt.format(fromDate))
        .replaceAll('{publishDateTo}', fmt.format(_toDate));
    _toDate = fromDate;
    print(url);

    try {
      var bidDoc = XmlDocument.parse(await http.read(url));
      bidDoc.findAllElements('notification').forEach((el) {
        var bid = Bid();
        bid
          ..bidNumber = el.getElement('bidNumber').text
          ..bidKindId = int.parse(el.getElement('bidKindId').text)
          ..bidKindName = el.getElement('bidKindName').text
          ..organizationName = el.getElement('organizationName').text
          ..isArchived = el.getElement('isArchived').text == '1'
          ..publishDate = DateTime.parse(el.getElement('publishDate').text)
          ..lastChanged = DateTime.parse(el.getElement('lastChanged').text)
          ..odDetailedHref = el.getElement('odDetailedHref').text;

        _all.add(bid);
      });

      _loadDetails(_all.sublist(_loadedDetails));
      _loadedDetails = _all.length;
    } catch (err) {
      print(err);
    }
  }

  void _loadDetails(List<Bid> bids) async {
    for (var bid in bids) {
      try {
        var url = bid.odDetailedHref.replaceAll('http://', 'https://');
        print(url);
        bid.xml = await http.read(url);
        var detail = XmlDocument.parse(bid.xml);
        bid.lots = [];
        detail.findAllElements('lot').forEach((el) {
          var descTags = ['description', 'propDesc', 'propName', 'location'];
          for (var descTag in descTags) {
            var desc = el.getElement(descTag);
            if (desc != null) {
              bid.lots.add(desc.text);
              break;
            }
          }
        });
      } catch (err) {
        print(err.toString());
      }
    }
  }

  List<Bid> _result() => _searchText == null
      ? List<Bid>.from(_all)
      : _all
          .where((bid) => bid.xml == null
              ? bid.bidKindName.toLowerCase().contains(_searchText) ||
                  bid.organizationName.toLowerCase().contains(_searchText)
              : bid.xml.toLowerCase().contains(_searchText))
          .toList();

  @override
  Stream<List<Bid>> mapEventToState(_BidEvent event) async* {
    if (event is Next) {
      _loadNext();
    } else if (event is Refresh) {
      _clear();
      _loadNext();
    } else if (event is Search) {
      _searchText = event.text.toLowerCase();
    }
    yield _result();
  }
}

const bidKinds = {
  1: 'Аренда госуд. и муницип. имущества',
  2: 'Аренда и продажа земельных участков',
  3: 'Строительство',
  4: 'Охотхозяйственные соглашения',
  5: 'Пользование участками недр',
  6: 'ГЧП/МЧП, концессии',
  7: 'Аренда и продажа лесных участков',
  8: 'Продажа гос. имущества',
  9: 'Передача прав на единые технологии',
  10: 'Водопользование',
  11: 'Рыболовство и добыча водных биоресурсов',
  12: 'ЖКХ',
  13: 'Реализация имущества должников',
  14: 'Создание искусственных земельных участков',
  15: 'Размещение рекламных конструкций',
  16: 'Продажа объектов электроэнергетики',
  17: 'Лицензии на оказание услуг связи',
};
