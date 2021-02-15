import 'package:diamond_fm_app/src/views/Splash%20Page/SplashPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Axiforma'
      ),
      home: SplashPage(),
    );
  }
}
