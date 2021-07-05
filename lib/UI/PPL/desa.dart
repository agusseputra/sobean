import 'package:flutter/material.dart';
import 'package:sobean/UI/widget/appbar.dart';

class Desapage extends StatefulWidget {
  @override
  _DesapageState createState() => _DesapageState();
}

class _DesapageState extends State<Desapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: appBar(context, "Desa"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Akun"),
              trailing: new Icon(Icons.supervised_user_circle),
            )
          ],
        ),
      ),
      body: Container(

      ),
    );
  }
}