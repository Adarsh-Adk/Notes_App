import 'package:flutter/material.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colours().mainColor,
          backgroundColor: Colours().backgroundColor,
          accentColor: Colours().accentColor),
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}
