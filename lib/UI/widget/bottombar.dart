import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildBottomBar(index, id_ppl,  id_penjual, BuildContext context){
    if(id_ppl!=''){
    return BottomNavigationBar(
          type: BottomNavigationBarType.fixed, 
          iconSize: 20,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          unselectedItemColor: Colors.white70,
          currentIndex: index??0,
          onTap: (i) {
            switch (i) {
              case 0:
                Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);
                break;
              case 1:
                Navigator.pushNamedAndRemoveUntil(context, "panenppl", (Route<dynamic> route) => false);
                break;
              case 2:
                Navigator.pushNamedAndRemoveUntil(context, "penjualppl", (Route<dynamic> route) => false);
                break;
              case 3:
                Navigator.pushNamedAndRemoveUntil(context, "kelompokppl", (Route<dynamic> route) => false);
                break;
              default:
            }
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home"),),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Panen"),),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),title: Text("Petani"),),
          BottomNavigationBarItem(icon: Icon(Icons.group),title: Text("Kelompok"),),
        ]
          
        );
    }else{
      return BottomNavigationBar(
            type: BottomNavigationBarType.fixed, 
            iconSize: 20,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: Colors.grey.shade800,
            backgroundColor: Colors.lightGreen,
            unselectedItemColor: Colors.white,
            currentIndex: index??0,
            onTap: (i) {
              switch (i) {
                case 0:
                  Navigator.pushNamedAndRemoveUntil(context, "dashboard", (Route<dynamic> route) => false);
                  break;
                case 1:
                  Navigator.pushNamedAndRemoveUntil(context, "panenppl", (Route<dynamic> route) => false);
                  break;
                default:
              }
            },
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home"),),
            BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Produk"),)
          ]
            
          );
    }
  }
  