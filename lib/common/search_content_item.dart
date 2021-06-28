import 'package:flutter/material.dart';

typedef SearchItemCall = void Function(String item);

class SearchItemView extends StatefulWidget {
  @override
  _SearchItemViewState createState() => _SearchItemViewState();
}

class _SearchItemViewState extends State<SearchItemView> {
  List<String> items = ['五月天', '周深', '毛不易', '华晨宇'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 10,
        // runSpacing: 0,
        children: items.map((item) {
          return SearchItem(title: item);
        }).toList(),
      ),
    );
  }
}

class SearchItem extends StatefulWidget {
  @required
  final String title;
  const SearchItem({Key key, this.title}) : super(key: key);
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Chip(
          label: Text(widget.title),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () {
          print(widget.title);
        },
      ),
      // color: Colors.white,
    );
  }
}
