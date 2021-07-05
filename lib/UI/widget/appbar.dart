import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
Widget appBar(BuildContext context, title) {
    return  Container(
      decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
      child: AppBar(          
            backgroundColor: Colors.lightGreen,
            title:  Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Badge(
                badgeContent: Text('3'),
                child: Icon(Icons.notifications_active),
              ),
              Badge(
                badgeContent: Text('3'),
                child: Icon(Icons.manage_accounts),
              ),
            ],
          ),
    );
}