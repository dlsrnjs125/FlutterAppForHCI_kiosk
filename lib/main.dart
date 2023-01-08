import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/screens/final.dart';
import 'screens/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue, primaryColor: Colors.white),
      // ignore: prefer_const_constructors
      home: MyStartPage(title: 'Flutter Demo Home Page'),
    );
  }
}
