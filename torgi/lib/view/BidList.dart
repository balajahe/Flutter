import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../model/BidModel.dart';
import '../view/BidView.dart';

class BidList extends StatefulWidget {
  @override
  createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  final _searchText = TextEditingController();
  String _visibleDate;
  ScrollController _scrollController = ScrollController();

  @override
  build(context) => Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchText,
            decoration: InputDecoration(
              hintText: "Найти...",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white60),
            ),
            cursorColor: Colors.white,
            onSubmitted: _search,
          ),
          actions: [
            IconButton(
              tooltip: 'Отменить поиск',
              icon: Icon(Icons.clear),
              onPressed: _cancelSearch,
            ),
            IconButton(
              tooltip: 'В начало',
              icon: Icon(Icons.arrow_upward),
              onPressed: () => _scrollController.jumpTo(0),
            ),
            IconButton(
              tooltip: 'Обновить',
              icon: Icon(Icons.refresh),
              onPressed: _refresh,
            ),
          ],
        ),
        body: BlocBuilder<BidModel, List<Bid>>(
          builder: (context, bids) => Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                itemCount: bids.length + 1,
                itemBuilder: (context, index) {
                  if (index < bids.length) {
                    var bid = bids[index];
                    return VisibilityDetector(
                      key: Key(bid.publishDate.toString()),
                      onVisibilityChanged: _onVisibility,
                      child: ListTile(
                        title: Text(
                          bidKinds[bid.bidKindId],
                          style: TextStyle(
                              color:
                                  bid.isArchived ? Colors.grey : Colors.green),
                        ),
                        subtitle: Text(bid.organizationName),
                        onTap: () => _onTap(bid),
                      ),
                    );
                  } else {
                    context.read<BidModel>().add(Next());
                    return Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: CircularProgressIndicator()));
                  }
                },
              ),
              _visibleDate != null
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, right: 10, left: 10),
                          color: Colors.white,
                          child: Text(
                            _visibleDate,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );

  void _refresh() {
    _searchText.text = '';
    _visibleDate = null;
    context.read<BidModel>().add(Refresh());
  }

  void _search(String text) {
    _visibleDate = null;
    _scrollController.jumpTo(0);
    context.read<BidModel>().add(Search(text));
  }

  void _cancelSearch() {
    _searchText.text = '';
    _visibleDate = null;
    _scrollController.jumpTo(0);
    context.read<BidModel>().add(Search(''));
  }

  void _onVisibility(VisibilityInfo event) {
    if (event.visibleFraction == 1) {
      setState(() => _visibleDate = event.key.toString().substring(3, 13));
    }
  }

  void _onTap(Bid bid) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        pageBuilder: (context, _, __) => BidView(bid),
      ),
    );
  }
}
