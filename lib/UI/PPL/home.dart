import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sobean/UI/PPL/dashboard.dart';
import 'package:sobean/UI/PPL/hotel.dart';
import 'package:sobean/UI/PPL/listScroll.dart';
import 'package:sobean/UI/PPL/panen.dart';
import 'package:sobean/UI/PPL/penjual.dart';
import 'package:sobean/UI/loginScreen.dart';

class Home extends StatefulWidget {
  static var routeName="home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>   with SingleTickerProviderStateMixin{
  late String name='';
  late int level=0;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  TabController? controller;
    Future<void> getPref() async {
    final SharedPreferences prefs = await preferences;    
    setState(() {
      level = prefs.getInt('level') ?? 0;
    });
    }

  @override
  void initState(){
    controller = new TabController(vsync: this,length: 5);
    super.initState();
    getPref();
    
  }
  //jangan lupa tambahkan dispose untuk berpindah halaman
  @override
  void dispose(){
    //controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 1:
      return Dashboard();
        // return Scaffold(
        //   drawer: new Drawer(
        //       child: new ListView(
        //         children: <Widget>[
        //           new ListTile(
        //             title: new Text("Akun"),
        //             trailing: new Icon(Icons.supervised_user_circle),
        //           )
        //         ],
        //       ),
        //     ),
        //   body: new TabBarView(
        //     controller: controller,
        //     children: <Widget>[
        //       new Dashboard(),
        //       new PanenPage(),
        //       new PenjualPage(),
        //       new HotelHomePage(),
        //       new SchoolList()
        //     ],
        //   ),
        //   bottomNavigationBar: new Material(
        //     color: Colors.lightGreen,
        //     child: TabBar(
        //       controller: controller,
        //       tabs: <Widget>[
        //         Container( child: Tab(icon: new Icon(Icons.home)),),
        //         Container( child: Tab(icon: new Image.asset("assets/icons/orange.png", width: 25, color: Colors.white))),
        //         Container( child: Tab(icon: new Image.asset("assets/icons/seller.png", width: 25, color: Colors.white))),
        //         Container( child: Tab(icon: new Image.asset("assets/icons/location_pin.png", width: 25, color: Colors.white))),
        //         Container( child: Tab(icon: new Image.asset("assets/icons/location_pin.png", width: 25, color: Colors.white)))
        //       ],
        //     ),
        //   ),
          
        // );
        break;
      default:
      return LoginScreen();
    }
  }
}