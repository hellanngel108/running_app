import 'package:flutter/material.dart';
import 'package:runningapp/screens/intro_page.dart';
import 'package:runningapp/screens/profile_page.dart';
import 'package:runningapp/services/auth.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        children: <Widget>[
          //Header
          UserAccountsDrawerHeader(
            accountName: Text('Hoang Minh Hong'),
            accountEmail: Text('minhhong0001@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person,color: Colors.white,),
              ),
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blue,),
              title: Text(
                "My Profile",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
          InkWell(
            onTap: (){
            },
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.blue,),
              title: Text(
                "Help & Supports",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.blue,),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
