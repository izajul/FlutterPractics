import 'package:first_flutter_app/app_screen/first_screen.dirt.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.deepPurple,
        child: Text(
          "Container Ex.",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.white,
            decoration: TextDecoration.lineThrough,
            fontFamily: "Raleway",
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
          ),
        ),
        //child: FirstScreen().getRandom(),
        //margin: EdgeInsets.only(left: 20.0,right: 20.0),
        //width: 200.0,
        // height: 100.0,
      ),
    );
  }
}
