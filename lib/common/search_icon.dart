import 'package:cc_music/common/search_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchIconState();
  }
}

class _SearchIconState extends State<SearchIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('test')),
      appBar: AppBar(
        title: Text("搜索"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              })
        ],
      ),
      body: Text(''),
    );
  }
}
