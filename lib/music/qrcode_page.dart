import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bind_dish_page.dart';

class QrCodeWidget extends StatefulWidget {
  final url;
  const QrCodeWidget({this.url}) : super();
  @override
  _QrCodeWidget createState() => _QrCodeWidget();
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // double eWidth = size.width / 15;
    // double wHeight = size.height / 15;
    // //
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      // ..color = Color(0x77cdb175);
      ..color = Colors.blueAccent;
    canvas.drawRect(Offset.zero & size, paint);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    Path path = Path();
    path.moveTo(0, 0);
    // path.addArc(Offset.zero & Size(40, 20), 10, 10);
    List<Offset> point = [
      Offset(0, 280),
      Offset(0, 300),
      Offset(100, 300),
      Offset(200, 380),
      Offset(250, 380),
      Offset(350, 300),
      Offset(450, 300),
      Offset(450, 280),
      Offset(100, 280),
      // Offset(100, 300)
    ];

    path.addPolygon(point, true);
    // path.addArc(Offset.zero & Size(50, 20), 10, 10);
    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawRect(Offset(0, 45) & Size(size.width, 100), paint);

    // paint
    //   ..style = PaintingStyle.fill
    //   ..color = Colors.blueAccent;
    // // canvas.drawCircle(Offset(140, 35), 30, paint);
    // canvas.drawOval(Offset(130, 0) & Size(70, 28), paint);
    // canvas.drawArc(Offset(130, 45) & Size(60, 50), 0, 5, true, paint);
    // canvas.drawPath(, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _QrCodeWidget extends State<QrCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blue,
        child: Stack(children: [
          Image.asset(
            'images/FoodBackground.jpg',
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topRight,
            fit: BoxFit.fitHeight,
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 80),
                      width: 300,
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomPaint(
                            size: Size(100, 20),
                            painter: MyPainter(),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 25, right: 25, bottom: 50, top: 0),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0),
                            child: Text('绑定菜品',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                QrImage(
                                  data: widget.url,
                                  version: QrVersions.auto,
                                  size: 250,
                                  gapless: false,
                                ),
                              ]),
                          IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          IconButton(
                              icon: Icon(Icons.style),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BindDishWidget()),
                                );
                              }),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 80),
                  padding:
                      EdgeInsets.only(left: 0, right: 0, bottom: 80, top: 0),
                )
              ])
        ]));
  }
}
