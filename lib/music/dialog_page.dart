import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  final text;
  const DialogWidget({this.text}) : super();
  @override
  _DialogWidget createState() => _DialogWidget();
}

class _DialogWidget extends State<DialogWidget> {
  // 提示
  Widget hIntWidget() => Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
          top: 100,
        ),
        child: Center(
            child: Column(children: [
          Image.asset(
            'images/890-loading-animation.gif',
            fit: BoxFit.cover,
            width: 180,
          ),
          Text(widget.text,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
        ])),
      );

  // 警告
  Widget warnWidget() => Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
          top: 100,
        ),
        child: Center(
            child: Column(children: [
          Image.asset(
            'images/890-loading-animation.gif',
            fit: BoxFit.cover,
            width: 180,
          ),
          Text(widget.text,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
        ])),
      );

  // 错误
  Widget errorWidget() => Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
          top: 100,
        ),
        child: Center(
            child: Column(children: [
          Image.asset(
            'images/890-loading-animation.gif',
            fit: BoxFit.cover,
            width: 180,
          ),
          Text(widget.text,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
        ])),
      );

  @override
  Widget build(BuildContext context) {
    return Material(child: hIntWidget());
  }
}
