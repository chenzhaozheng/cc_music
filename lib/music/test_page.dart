import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TestWidget extends StatefulWidget {
  final url;
  const TestWidget({this.url}) : super();
  @override
  _TestWidget createState() => _TestWidget();
}

class _TestWidget extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blue,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 0, right: 0, bottom: 80, top: 0),
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 25, bottom: 50, top: 0),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  child: Text('绑定菜品',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  QrImage(
                    data: widget.url,
                    version: QrVersions.auto,
                    size: 280,
                    gapless: false,
                  ),
                ]),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 8,
            //   ),
            //   borderRadius: BorderRadius.circular(12),
            // ),
          )
        ]));
  }
}
