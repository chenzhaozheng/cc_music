import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AnimationController controller;

class Rotation extends StatelessWidget {
  // @override
  Widget build(BuildContext context) {
    return Row(children: [
      RotationTransition(
          alignment: Alignment.center,
          turns: controller,
          child: Container(
            width: 20,
            height: 20,
            color: Colors.blue,
          )),
    ]);
    // child: ;
  }
}
