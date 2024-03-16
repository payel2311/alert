import 'package:flutter/material.dart';
import 'package:newproject/screeens/LogInScreen.dart';
import 'package:newproject/screeens/RegScreen.dart';
import 'package:newproject/screeens/instructions.dart';
import 'package:newproject/screeens/SavedContact.dart';
//import 'fourth.dart';
//import 'five.dart';
import 'AddInfo.dart';
import 'Button.dart';
import 'ProfilePage.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.push(context,
              MaterialPageRoute(builder: (context) => ButtonPage()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
          )},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Add Contact'),
            onTap: () => {Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddInfo()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Instructions'),
            onTap: () => {Navigator.push(context,
              MaterialPageRoute(builder: (context) => Instructions()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Saved Contacts'),
            onTap: () => {Navigator.push(context,
    MaterialPageRoute(builder: (context) => SavedContact()),
    )},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LogOut'),
            onTap: () => {Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegScreen()),
            )},
          ),
        ],
      ),
    );
  }
}