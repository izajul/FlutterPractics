import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Flutter StatrFul Widget Example",
      home: FavoriteCity(),
    )
  );
}

class FavoriteCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State{

  String cityName = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("StateFul App Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String input){
                setState(() {
                  cityName = input;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Your Fevorate City Is $cityName",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }

}