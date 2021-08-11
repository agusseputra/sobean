import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


Widget drawerBar(BuildContext context)  {
 //SharedPreferences preferences =  SharedPreferences.getInstance() as SharedPreferences;
 var name =  "";
 var email =  "";
  signOut()  {
   //  preferences.clear();
    //redirect login
    Navigator.pushNamedAndRemoveUntil(context, "login", (Route<dynamic> route) => false);
  }
  return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            new UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new GestureDetector(
              onTap: () {},
              // child: new CircleAvatar(
              //   //mengambil gambar dari internet menggunakan NetworkImage
              //   backgroundImage: new NetworkImage(
              //       'https://dosen.undiksha.ac.id/admin/media/ujm/dosen/0015089006/0015089006_photo_profile.jpg'),
              // ),
            ),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage('assets/carosel/world1.png'),
              //       fit: BoxFit.cover),
              // ),            
            ),
            new ListTile(
            title: new Text('Notifications'),
            trailing: new Icon(Icons.notifications_none),
            ),
            new ListTile(
              title: new Text('Akun'), trailing: new Icon(Icons.verified_user),
            ),
            new ListTile(
              title: new Text('setting'),trailing: new Icon(Icons.settings),
            ),
            Divider(height: 2,),
            new ListTile(
              title: new Text('Logout'),trailing: new Icon(Icons.logout),
              onTap: (){
                  signOut();
              },
            ),

          ],
        ),
      );

}