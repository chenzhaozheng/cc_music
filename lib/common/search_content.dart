import 'package:cc_music/common/search_content_item.dart';
import 'package:flutter/material.dart';

typedef SearchItemCall = void Function(String item);

class SearchContentView extends StatefulWidget {
  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '大家都在搜',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SearchItemView(),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child: Text(
          //     '历史记录',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
          // SearchItemView()
        ],
      ),
    );
  }
}
