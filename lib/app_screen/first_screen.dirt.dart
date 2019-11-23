import 'dart:math';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Center(
        child: getRandom(),
      ),
    );
  }

  Widget getRandom() {
    var random = new Random();
    return Text("The random number is: ${random.nextInt(10)}",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Colors.white,
        ));
  }
}
