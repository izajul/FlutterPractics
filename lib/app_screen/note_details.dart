import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget{
  String _title ;
  NoteDetails(this._title);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState (_title);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priorities = ['high','low'];
  var _commonPadding = 15.0;
  String _title;

  NoteDetailsState(this._title); //constructor assign value

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    return WillPopScope(
      onWillPop:(){return _routeScreenPOP();},
      child: Scaffold(
      appBar: AppBar(title: Text(_title),leading: IconButton(icon: Icon(Icons.arrow_back,), onPressed: (){
        _routeScreenPOP();
      })),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0,top:15.0,right: 10.0),
        child: ListView(
          children: <Widget>[
            // first element
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownItem){
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(dropDownItem),
                  );
                }).toList(),
                style: textStyle,
                value: _priorities[1],
                onChanged: (selectedValue){
                  setState(() {
                    debugPrint("user selected $selectedValue");
                  });
                },
              ),
            ),
            //second element
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,left: _commonPadding/2,right: _commonPadding/2),
              child: TextField(
                controller: _titleController,
                style: textStyle,
                onChanged: (value){
                  //Todo: will add some code later ..
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            //second element
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,left: _commonPadding/2,right: _commonPadding/2),
              child: TextField(
                controller: _descriptionController,
                style: textStyle,
                onChanged: (value){
                  //todo: will add some code later ..
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "Description",
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            //third element
            Padding(
              padding: EdgeInsets.only(top: _commonPadding,left: _commonPadding/2,right: _commonPadding/2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Save",textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                          //todo: will add some code hear
                        });
                      },
                    ),
                  ),
                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Delete",textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                          //todo: will add some code hear
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<bool> _routeScreenPOP() async{
    Navigator.pop(context);
    return false;
  }
}