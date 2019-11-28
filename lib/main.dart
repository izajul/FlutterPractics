import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      title: "Simple Calculator",
      home: SIForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
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
  var _currentSelectedItem = '';
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  var _displaystage = '';

  TextEditingController principleController   = TextEditingController();
  TextEditingController rateController        = TextEditingController();
  TextEditingController termController        = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar:AppBar(title: Text("Simple Calculator"),),
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(_commonPadding*4),
            child: ListView(
              children: <Widget>[
                Center(child: getImageAsset(),),
                Padding(
                  padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principleController,
                    validator: (String value){
                      if(value.isEmpty) {
                        return "Please Enter Priciple Amount !";
                      }else return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Principle",
                      hintText: "Enter Principle e.g. 1200",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: rateController,
                    validator: (String value){
                      if(value.isEmpty) {
                        return "Please Enter The Rate !";
                      }else return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Rate Of Interest",
                      hintText: "In The Pareent",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
                  child:Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (String value){
                            if(value.isEmpty) {
                              return "Please Enter Term!";
                            }else return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Term",
                            hintText: "Term In years",
                            labelStyle: textStyle,
                            errorStyle: TextStyle(color:Colors.yellowAccent,fontSize: 15.0),
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
                                child: Text(value,style: textStyle,),
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
                          color:Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text("Calculate",textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              if(formKey.currentState.validate()){
                                this._displaystage = _calculateTotalRate();
                              }
                            });
                          },
                        ),
                      ),
                      //Container(width: _commonPadding*4,),
                      Expanded(
                        child: RaisedButton(
                          color:Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text("Rest",textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              _resetAll();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _commonPadding,bottom: _commonPadding),
                  child: Text(this._displaystage,style: textStyle,),
                )
              ],

            )),

      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(image: assetImage,height: 150.0,width: 150.0,);
    return Container(child: image,margin: EdgeInsets.all(_commonPadding*2),);
  }




  String _calculateTotalRate() {
    double principle = double.parse(principleController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double payment = principle+(principle*rate*term)/100;
    return "After $term years, Your Investment will $payment $_currentSelectedItem";
  }

  void _resetAll() {
    _currentSelectedItem = _currencies[0];
    _displaystage = '';
    principleController.text = '';
    rateController.text = '';
    termController.text = '';
  }
}

