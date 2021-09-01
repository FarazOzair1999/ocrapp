import 'package:flutter/material.dart';
import 'package:ocrapp/MainScreenForm.dart';
import 'package:ocrapp/homePage.dart';
import 'package:ocrapp/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
