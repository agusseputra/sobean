import 'package:flutter/material.dart';
import 'package:sobean/UI/PPL/dashboard.dart';
import 'package:sobean/UI/PPL/home.dart';
import 'package:sobean/UI/PPL/kelompok.dart';
import 'package:sobean/UI/PPL/panen.dart';
import 'package:sobean/UI/PPL/penjual.dart';
import 'package:sobean/UI/loginScreen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black,
        cursorColor: Colors.black,
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.orange,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: Home(),
      initialRoute: Home.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        Home.routeName: (context) => Home(),
        Dashboard.routeName: (context) => Dashboard(),
        PanenPage.routeName:(context)=>PanenPage(),
        PenjualPage.routeName:(context)=>PenjualPage(),
        KelompokPage.routeName:(context)=>KelompokPage()
      },
    );
  }
}
