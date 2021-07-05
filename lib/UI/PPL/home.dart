import 'package:flutter/material.dart';
import 'package:sobean/UI/PPL/dashboard.dart';
import 'package:sobean/UI/PPL/hotel.dart';
import 'package:sobean/UI/PPL/listScroll.dart';
import 'package:sobean/UI/PPL/panen.dart';
import 'package:sobean/UI/PPL/penjual.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>   with SingleTickerProviderStateMixin{
  TabController? controller;
  @override
  void initState(){
    controller = new TabController(vsync: this,length: 5);
    super.initState();
    
  }
  //jangan lupa tambahkan dispose untuk berpindah halaman
  @override
  void dispose(){
    //controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new Dashboard(),
          new PanenPage(),
          new PenjualPage(),
          new HotelHomePage(),
          new SchoolList()
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.lightGreen,
        child: TabBar(
          controller: controller,
          tabs: <Widget>[
            Container( child: Tab(icon: new Icon(Icons.home)),),
            Container( child: Tab(icon: new Image.asset("assets/icons/orange.png", width: 25, color: Colors.white))),
            Container( child: Tab(icon: new Image.asset("assets/icons/seller.png", width: 25, color: Colors.white))),
            Container( child: Tab(icon: new Image.asset("assets/icons/location_pin.png", width: 25, color: Colors.white))),
            Container( child: Tab(icon: new Image.asset("assets/icons/location_pin.png", width: 25, color: Colors.white)))
          ],
        ),
      ),
      
    );
  }
}