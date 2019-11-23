import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
            alignment: Alignment.center,
            color: Colors.deepPurple,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    getText("wow"),
                    getText("its workgin"),
                    getText("so NIce")
                  ],
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    getText("wow"),
                    getText("its workgin"),
                    getText("so NIce")
                  ],
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    getText("wow"),
                    getText("its workgin"),
                    getText("so NIce")
                  ],
                ),
                ImageAssets(),
                RaisedButtons()
              ],
            )),
      );

  Widget getText(String msg) => Expanded(
          child: Text(
        "Container E..x. $msg",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          decoration: TextDecoration.none,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
        ),
      ));
}

class ImageAssets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("images/my_location.png");
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 200.0,
    );
    return Container(
      child: RaisedButton(child: image, onPressed: () => showSnackBar(context,"Image Click")),
    );
  }
}

class RaisedButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 20.0),
        width: 250.0,
        height: 50.0,
        child: RaisedButton(
            color: Colors.deepOrange,
            child: Text("Sample Button",
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.white)),
            elevation: 5.0,
            onPressed: () => showAlert(context)),
      );
}

void showAlert(BuildContext context) {
  var dialog = AlertDialog(
    title: Text("Test Dialog"),
    content: getList(context),
    backgroundColor: Colors.deepOrange,
    elevation: 10.0,
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

Widget getList(BuildContext context) {
  var list = ListView(
    children: <Widget>[
      ListTile(
          leading: Icon(Icons.image),
          title: Text("Just Image"),
          subtitle: Text("Demo Image Subtitle"),
          trailing: Icon(Icons.add),
          onTap: null),
    ],
  );

  return Scaffold(
    body: list,
  );
}

showSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text("A SnackBar! From "+msg),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.
  Scaffold.of(context).showSnackBar(snackBar);
}
