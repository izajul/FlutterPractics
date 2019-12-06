import 'package:first_flutter_app/db/database_helper.dart';
import 'package:first_flutter_app/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NoteDetails extends StatefulWidget{
  final String _title ;
  Note _note;
  NoteDetails(this._note,this._title);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState (_note,_title);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priorities = ['high','low'];
  var _commonPadding = 15.0;
  String _title;
  Note _note;

  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  NoteDetailsState(this._note,this._title); //constructor assign value
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    _titleController.text = _note.title;
    _descriptionController.text = _note.description;

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
                value: (_note.priority==0)?_priorities[0]:_priorities[1],
                onChanged: (selectedValue){
                  setState(() {
                    _updatePriorityAsInt(selectedValue);
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
                  _note.title = _titleController.text;
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
                  _note.description = _descriptionController.text;
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
                          _saveBtn();
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
                          _deleteNote();
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
    Navigator.pop(context,true);
    return false;
  }

  void _updatePriorityAsInt(selectedValue) {
    (selectedValue=='high')?_note.priority = 0 : _note.priority = 1;
  }

  void _saveBtn() async {
    _routeScreenPOP();
    int result=0 ;
    _note.date = DateFormat.yMMMd().format(DateTime.now());
    if(_note.id !=  null) { // Update existing one
      result = await _dataBaseHelper.updateNote(_note);
    }else{ // Create New One
      result = await  _dataBaseHelper.insertNote(_note);
    }

    if (result != 0){ //success
      _showAlertDialog("Status","Note Save Successfully");
    }else{ // failure
      _showAlertDialog("Status", "Problem In Saving Note!");
    }
  }

  void _showAlertDialog(String title, String msg){
    AlertDialog ad = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context,builder: (_) => ad);
  }

  void _deleteNote() async {
    _routeScreenPOP();
    if(_note.id ==  null) { // Update existing one
      _showAlertDialog("Status", "No Note Was Deleted");
      return;
    }
    int result = await _dataBaseHelper.deleteNote(_note);
    if (result != 0){ //success
      _showAlertDialog("Status","Note Delete Successfully");
    }else{ // failure
      _showAlertDialog("Status", "Problem In Deleting Note!");
    }
  }
}