import 'package:flutter/material.dart';

const textStyle = const TextStyle(
    // fontFamily: 'Raleway',
    fontWeight: FontWeight.bold,
    fontSize: 20);

class Index extends StatelessWidget {
  Widget recommend = Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Hi shadow 今日为你打造', style: textStyle),
      Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   'images/zhizu.jpg',
          //   fit: BoxFit.cover,
          // )
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/zhoujielun.jpg'),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Color(0xFFFF0000), width: 0.5),
              color: Color(0xFF9E9E9E),
              borderRadius:
                  BorderRadius.vertical(top: Radius.elliptical(20, 50)),
            ),
          ),
          Image.asset('images/zhoujielun.jpg', fit: BoxFit.cover),
          Image.asset('images/zhoujielun.jpg', fit: BoxFit.cover),
        ],
      )
    ],
  ));

  Widget door = Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '歌单传送门',
        style: textStyle,
      ),
      Row(
        children: [
          Image.asset('images/zhoujielun.jpg', fit: BoxFit.cover),
          Image.asset('images/zhoujielun.jpg', fit: BoxFit.cover),
        ],
      )
    ],
  ));

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [recommend, door],
        ));
  }
}
