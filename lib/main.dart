import 'package:flutter/material.dart';
import 'LoginScreen.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Simple Login App',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

