import 'package:first_flutter_app/app_screen/first_screen.dirt.dart';
import 'package:first_flutter_app/app_screen/home.dart';
import 'package:flutter/material.dart';
import 'app_screen/column&row.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My First Flutter App",
    home: Scaffold(
      appBar: AppBar(title: Text("First Flutter App"),

      ),
     floatingActionButton: FloatingActionButton(
       onPressed: null,
       child: Icon(Icons.add),
       tooltip: "Add one More Item",
     ),
     // body: new ColumnRow(),
      body: getLongListView()
    ),)
);

List<String> getListItems() => List<String>.generate(1000, (counter) => "Item $counter");

Widget getLongListView(){
  var listItem = getListItems();
  var listView = ListView.builder(
      itemCount: listItem.length,
      itemBuilder:(context,index) => ListTile(
        leading: Icon(Icons.airplay),
          title: Text(listItem[index]),
          onTap: (){
            showSnackBar(context,listItem[index]);
          },
        )
  );
  return listView;
}

/*
class MyClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "First Flutter App",
        home: Scaffold(
          appBar: AppBar(title: Text("First Flutter app")),
          body: FirstScreen(),
        ));
  }
}
*/
