import 'package:flutter/material.dart';
import 'package:imagecaptioningapp/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
