import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      // ..color = Color(0x77cdb175);
      ..color = Colors.blueAccent;
    canvas.drawRect(Offset.zero & size, paint);

    // paint
    //   ..style = PaintingStyle.fill
    //   ..color = Colors.redAccent;
    // Path path = Path();
    // path.moveTo(0, 0);
    // // path.addArc(Offset.zero & Size(40, 20), 10, 10);
    // List<Offset> point = [
    //   Offset(0, 280),
    //   Offset(0, 300),
    //   Offset(100, 300),
    //   Offset(200, 380),
    //   Offset(250, 380),
    //   Offset(350, 300),
    //   Offset(450, 300),
    //   Offset(450, 280),
    //   Offset(100, 280),
    //   // Offset(100, 300)
    // ];

    // path.addPolygon(point, true);
    // // path.addArc(Offset.zero & Size(50, 20), 10, 10);
    // canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawRect(Offset(0, 45) & Size(size.width, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _QrCodeWidget extends State<QrCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Stack(
        children: [
          Image.asset(
            'images/FoodBackground.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
          Center(
            child: _whiteBox,
          ),
        ],
      ),
    );
  }

  get _whiteBox => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 300,
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _content,
                )
              ],
            ),
          ]);

  get _content => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: CustomPaint(
              size: Size(100, 20),
              painter: MyPainter(),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            child: Text('绑定=菜品',
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
          Container(
            child: Center(
              child: QrImage(
                data: widget.url,
                version: QrVersions.auto,
                size: 250,
                gapless: false,
              ),
            ),
          ),
          Container(
              width: 100,
              height: 100,
              child: Center(
                child: TextButton(
                    child: Text('切换至页面绑定c',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(
                        //     builder: (context) =>
                        //         BindDishWidget(url: widget.url)),
                        MaterialPageRoute(
                          settings: RouteSettings(name: 'bind_page'),
                          builder: (context) => BindDishWidget(url: widget.url),
                        ),
                      );
                    }),
              )),
          // IconButton(
          //     icon: Icon(Icons.first_page),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     }),
        ],
      );
}
