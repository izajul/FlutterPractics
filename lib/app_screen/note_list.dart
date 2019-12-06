import 'package:first_flutter_app/app_screen/note_details.dart';
import 'package:first_flutter_app/db/database_helper.dart';
import 'package:first_flutter_app/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NoteListSate();
  }

}

class NoteListSate extends State<NoteList>{
  var count = 0;
  DataBaseHelper _dataBaseHelper = DataBaseHelper();
  List<Note> _noteList ;

  @override
  Widget build(BuildContext context) {
    if(_noteList == null){
      _noteList = List<Note>();
      _updateListView();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Notes"),),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _routeScreen(Note(2,'',''),"Add New List");
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
    );
  }

  getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context,int positon){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this._noteList[positon].title,style: titleStyle,),
            subtitle: Text(this._noteList[positon].date),
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this._noteList[positon].priority),
              child: getPriorityIcon(this._noteList[positon].priority),
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete,color: Colors.grey,),
              onTap: (){
                _delete(context, this._noteList[positon]);
              },
            ),
            onTap: (){
              _routeScreen(this._noteList[positon],"Edit Note Details");
            },
          ),
        );
      },
      
    );
  }

  Color getPriorityColor(int priority){
    switch(priority){
      case 0: return Colors.red;break;
      case 1: return Colors.yellow;break;
      default: return Colors.yellow;break;
    }
  }

  Icon getPriorityIcon(int priority){
    switch(priority){
      case 0: return Icon(Icons.play_arrow);break;
      case 1: return Icon(Icons.keyboard_arrow_right);break;
      default: return Icon(Icons.keyboard_arrow_right);break;
    }
  }

  void _delete(BuildContext context,Note note) async {
    int result = await _dataBaseHelper.deleteNote(note);
    if(result != 0 ){
      _showSnackBar(context, "Note Deleted Successfully");

      _updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String msg){
    final snackBar = SnackBar(content: Text(msg),);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _routeScreen(Note note,String s) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetails(note,s);
    }));
    if(result == true){
      _updateListView();
    }
  }

  void _updateListView() async {
    final Future<Database> dbFuture = _dataBaseHelper.initializeDB();
    dbFuture.then((database){
      Future<List<Note>> noteListFuture = _dataBaseHelper.getNoteList();
      noteListFuture.then((notelist){
        setState(() {
          this._noteList = notelist;
          this.count = notelist.length;
        });
      });
    });
  }
  
}