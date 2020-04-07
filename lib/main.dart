import 'package:flutter/material.dart';
import 'package:runningapp/screens/home_page.dart';
import 'package:runningapp/screens/intro_page.dart';
import 'package:runningapp/screens/login_page.dart';
import 'package:runningapp/screens/profile_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
