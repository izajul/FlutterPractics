import 'package:first_flutter_app/app_screen/note_details.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NoteListSate();
  }

}

class NoteListSate extends State<NoteList>{
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes"),),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _routeScreen("Add New List");
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
            title: Text("dummy title",style: titleStyle,),
            subtitle: Text("dummy description"),
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            trailing: Icon(Icons.delete,color: Colors.grey,),
            onTap: (){
              _routeScreen("Edit Note Details");
            },
          ),
        );
      },
      
    );
  }

  void _routeScreen(String s) {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetails(s);
    }));
  }
  
}