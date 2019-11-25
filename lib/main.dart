import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      title: "Simple Calculator",
      home: SIForm(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  final _commonPadding = 5.0;
  var _currencies = ['Taka','Dollars','Rupees','Uros','Others'];
  var _currentSelectedItem = 'Taka';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(title: Text("Simple Calculator"),),
      body: Container(
        padding: EdgeInsets.all(_commonPadding*4),
        child: ListView(
          children: <Widget>[
            Center(child: getImageAsset(),),
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Principle",
                  hintText: "Enter Principle e.g. 1200",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Rate Of Interest",
                  hintText: "In The Pareent",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Term",
                        hintText: "Term In years",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  Container(width: _commonPadding*5,),
                  Expanded(
                    child: DropdownButton<String>(
                        items: _currencies.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentSelectedItem,
                        onChanged: (String selectedValue){
                          setState(() {
                            _currentSelectedItem = selectedValue;
                          });
                        },
                      ),
                  )
                ],
              )),
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text("Calculate"),
                      onPressed: (){
                        //Todo: here will be add some calculation later...
                      },
                    ),
                  ),
                  Container(width: _commonPadding*4,),
                  Expanded(
                    child: RaisedButton(
                      child: Text("Rest"),
                      onPressed: (){
                        //Todo: here will be add some calculation later...
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
              child: Text("//Todo: Something to do.."),
            )
          ],

        ),

      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(image: assetImage,height: 150.0,width: 150.0,);
    return Container(child: image,margin: EdgeInsets.all(_commonPadding*2),);
  }

}